-- replace vim-doge
local M = {}

M.config = {
	keymap = "<leader>d", -- false で無効
}

-- snippet 内で特別扱いされる文字(\ $ })をエスケープ
local function esc(s)
	return (s:gsub("[\\$}]", "\\%0"))
end
local function strip_colon(s)
	return (s:gsub("^:%s*", ""))
end
local function text(node, buf)
	return vim.treesitter.get_node_text(node, buf)
end
local function field(node, name)
	return node:field(name)[1]
end
local function warn(msg)
	vim.notify("doge: " .. msg, vim.log.levels.WARN)
end

-- 入れ子の関数は return の判定から除外する
local NESTED = {
	function_definition = true,
	function_declaration = true,
	method_declaration = true,
	method_definition = true,
	arrow_function = true,
	anonymous_function = true,
	anonymous_function_creation_expression = true,
	function_expression = true,
	["function"] = true,
	generator_function = true,
	class_declaration = true,
}

--- 値を返す return があるか
local function has_return(node)
	for c in node:iter_children() do
		local t = c:type()
		if t == "return_statement" then
			if c:named_child_count() > 0 then
				return true
			end
		elseif not NESTED[t] and has_return(c) then
			return true
		end
	end
	return false
end

local function body_returns(node)
	local body = field(node, "body")
	return body ~= nil and has_return(body)
end

local function prev_line_matches(buf, row, pats)
	if row == 0 then
		return false
	end
	local l = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1] or ""
	for _, p in ipairs(pats) do
		if l:match(p) then
			return true
		end
	end
	return false
end

local C_END = { "^%s*%*/%s*$" }
local LUA_DOC = { "^%s*%-%-%-" }

----------------------------------------------------------------------
-- 言語ごとの定義
-- types      : 関数を表すノード種別
-- accept     : (任意) そのノードを対象にしてよいか
-- anchor     : コメントを置く位置の基準ノード
-- inside     : (任意) 関数の中に書く言語用。row, indent を返す
-- params     : { {name=, type=, variadic=}, ... }
-- ret        : nil=戻り値なし / ""=型不明 / "type"=型あり
-- documented : すでにコメントがあるか
-- render     : snippet 文字列を返す
----------------------------------------------------------------------
local LANGS = {}

-- ===== PHP (PHPDoc) =====
LANGS.php = {
	types = { function_definition = true, method_declaration = true },
	anchor = function(n)
		return n
	end,
	documented = function(_, row, buf)
		return prev_line_matches(buf, row, C_END)
	end,
	params = function(node, buf)
		local out = {}
		local ps = field(node, "parameters")
		if not ps then
			return out
		end
		for p in ps:iter_children() do
			local t = p:type()
			if t == "simple_parameter" or t == "variadic_parameter" or t == "property_promotion_parameter" then
				local name, ty = field(p, "name"), field(p, "type")
				out[#out + 1] = {
					name = name and text(name, buf) or "$param",
					type = ty and text(ty, buf) or nil,
					variadic = t == "variadic_parameter",
				}
			end
		end
		return out
	end,
	ret = function(node, buf)
		local nm = field(node, "name")
		if nm and text(nm, buf) == "__construct" then
			return nil
		end
		local rt = field(node, "return_type")
		if rt then
			local s = strip_colon(text(rt, buf))
			if s == "void" or s == "never" then
				return nil
			end
			return s
		end
		return body_returns(node) and "" or nil
	end,
	render = function(c)
		local L = { " /**", " * " .. c.ph("Description") }
		local tags = {}
		for _, p in ipairs(c.params) do
			local ty = p.type and esc(p.type) or "mixed"
			local name = esc((p.variadic and "..." or "") .. p.name)
			tags[#tags + 1] = (" * @param %s %s"):format(ty, name)
		end
		if c.ret then
			local ty = c.ret ~= "" and esc(c.ret) or "mixed"
			tags[#tags + 1] = (" * @return %s"):format(ty)
		end
		if #tags > 0 then
			L[#L + 1] = " *"
			vim.list_extend(L, tags)
		end
		L[#L + 1] = " */"
		return table.concat(L, "\n")
	end,
}
LANGS.php_only = LANGS.php -- Blade などに埋め込まれた PHP

-- ===== Lua (LuaLS アノテーション) =====
LANGS.lua = {
	types = { function_declaration = true, function_definition = true },
	-- コールバック(引数に渡す function)は対象外。代入・テーブルフィールドだけ
	accept = function(n)
		if n:type() == "function_declaration" then
			return true
		end
		local p = n:parent()
		return p ~= nil and (p:type() == "expression_list" or p:type() == "field")
	end,
	anchor = function(n)
		while n:parent() do
			local pt = n:parent():type()
			if pt == "chunk" or pt == "block" or n:type() == "field" then
				break
			end
			n = n:parent()
		end
		return n
	end,
	documented = function(_, row, buf)
		return prev_line_matches(buf, row, LUA_DOC)
	end,
	params = function(node, buf)
		local out = {}
		local ps = field(node, "parameters")
		if not ps then
			return out
		end
		for p in ps:iter_children() do
			if p:named() and p:type() ~= "comment" then
				out[#out + 1] = { name = text(p, buf) }
			end
		end
		return out
	end,
	ret = function(node)
		return body_returns(node) and "" or nil
	end,
	render = function(c)
		local L = { "--- " .. c.ph("Description") }
		for _, p in ipairs(c.params) do
			local ty = "type"
			local desc = "Description"
			L[#L + 1] = ("---@param %s %s %s"):format(esc(p.name), ty, desc)
		end
		if c.ret then
			L[#L + 1] = "---@return " .. "type"
		end
		return table.concat(L, "\n")
	end,
}

-- ===== JavaScript / TypeScript (JSDoc) =====
local JS_FN_EXPR = { arrow_function = true, function_expression = true, ["function"] = true }
local JS_ASSIGNED = {
	variable_declarator = true,
	assignment_expression = true,
	pair = true,
	public_field_definition = true,
	field_definition = true,
	export_statement = true,
}
local JS_CLIMB = {
	export_statement = true,
	variable_declarator = true,
	lexical_declaration = true,
	variable_declaration = true,
	assignment_expression = true,
	expression_statement = true,
	public_field_definition = true,
	field_definition = true,
}

local function js_name(p, buf)
	local t = p:type()
	if t == "identifier" then
		return text(p, buf)
	end
	if t == "assignment_pattern" then
		local l = field(p, "left")
		return l and js_name(l, buf) or "param"
	end
	if t == "rest_pattern" then
		local c = p:named_child(0)
		return "..." .. (c and js_name(c, buf) or "args")
	end
	if t == "object_pattern" then
		return "options"
	end
	if t == "array_pattern" then
		return "items"
	end
	return "param"
end

local function js_spec(ts)
	return {
		types = {
			function_declaration = true,
			generator_function_declaration = true,
			method_definition = true,
			arrow_function = true,
			function_expression = true,
			["function"] = true,
		},
		-- コールバックは対象外。変数・プロパティに代入された関数だけ
		accept = function(n)
			if JS_FN_EXPR[n:type()] then
				local p = n:parent()
				return p ~= nil and JS_ASSIGNED[p:type()] == true
			end
			return true
		end,
		anchor = function(n)
			while n:parent() and JS_CLIMB[n:parent():type()] do
				n = n:parent()
			end
			return n
		end,
		documented = function(_, row, buf)
			return prev_line_matches(buf, row, C_END)
		end,
		params = function(node, buf)
			local out = {}
			local ps = field(node, "parameters")
			if ps then
				for p in ps:iter_children() do
					local t = p:type()
					if p:named() and t ~= "comment" then
						if t == "required_parameter" or t == "optional_parameter" then
							local pat, ty = field(p, "pattern"), field(p, "type")
							out[#out + 1] = {
								name = pat and js_name(pat, buf) or "param",
								type = ty and strip_colon(text(ty, buf)) or nil,
							}
						else
							out[#out + 1] = { name = js_name(p, buf) }
						end
					end
				end
			else
				local single = field(node, "parameter") -- x => ...
				if single then
					out[1] = { name = js_name(single, buf) }
				end
			end
			return out
		end,
		ret = function(node, buf)
			local nm = field(node, "name")
			if node:type() == "method_definition" and nm and text(nm, buf) == "constructor" then
				return nil
			end
			local rt = field(node, "return_type")
			if rt then
				local s = strip_colon(text(rt, buf))
				if s == "void" or s == "never" then
					return nil
				end
				return s
			end
			local body = field(node, "body")
			if not body then
				return nil
			end
			if body:type() ~= "statement_block" then
				return ""
			end -- x => expr
			return has_return(body) and "" or nil
		end,
		render = function(c)
			local L = { "/**", " * " .. c.ph("Description") }
			local tags = {}
			for _, p in ipairs(c.params) do
				local ty = ""
				if not ts then
					ty = "{" .. (p.type and esc(p.type) or c.ph("type")) .. "} "
				end
				local desc = c.ph("Description")
				tags[#tags + 1] = (" * @param %s%s %s"):format(ty, esc(p.name), desc)
			end
			if c.ret then
				local ty = ""
				if not ts then
					ty = "{" .. (c.ret ~= "" and esc(c.ret) or c.ph("type")) .. "} "
				end
				tags[#tags + 1] = (" * @returns %s%s"):format(ty, c.ph("Description"))
			end
			if #tags > 0 then
				L[#L + 1] = " *"
				vim.list_extend(L, tags)
			end
			L[#L + 1] = " */"
			return table.concat(L, "\n")
		end,
	}
end
LANGS.javascript = js_spec(false)
LANGS.typescript = js_spec(true)
LANGS.tsx = LANGS.typescript

-- ===== Python (Google スタイルの docstring) =====
LANGS.python = {
	types = { function_definition = true },
	-- docstring は関数の中(最初の文の前)に入れる
	inside = function(node, buf)
		local body = field(node, "body")
		if not body then
			return nil
		end
		local r = body:range()
		local colon = body:prev_sibling()
		if colon then
			local _, _, er = colon:range()
			if r <= er then
				return nil
			end -- def f(): pass のような1行定義
		end
		local line = vim.api.nvim_buf_get_lines(buf, r, r + 1, false)[1] or ""
		return r, line:match("^%s*")
	end,
	documented = function(node)
		local body = field(node, "body")
		local first = body and body:named_child(0)
		if first and first:type() == "expression_statement" then
			local s = first:named_child(0)
			return s ~= nil and s:type() == "string"
		end
		return false
	end,
	params = function(node, buf)
		local out = {}
		local ps = field(node, "parameters")
		if not ps then
			return out
		end
		for p in ps:iter_children() do
			local t = p:type()
			local name, ty
			if t == "identifier" or t == "list_splat_pattern" or t == "dictionary_splat_pattern" then
				name = text(p, buf)
			elseif t == "typed_parameter" then
				local id = p:named_child(0)
				local tt = field(p, "type")
				name = id and text(id, buf)
				ty = tt and text(tt, buf)
			elseif t == "default_parameter" or t == "typed_default_parameter" then
				local id, tt = field(p, "name"), field(p, "type")
				name = id and text(id, buf)
				ty = tt and text(tt, buf)
			end
			if name and name ~= "self" and name ~= "cls" then
				out[#out + 1] = { name = name, type = ty }
			end
		end
		return out
	end,
	ret = function(node, buf)
		local rt = field(node, "return_type")
		if rt then
			local s = text(rt, buf)
			return s == "None" and nil or s
		end
		return body_returns(node) and "" or nil
	end,
	render = function(c)
		if #c.params == 0 and not c.ret then
			return '"""' .. c.ph("Description") .. '"""'
		end
		local L = { '"""' .. c.ph("Description"), "" }
		if #c.params > 0 then
			L[#L + 1] = "Args:"
			for _, p in ipairs(c.params) do
				local ty = p.type and esc(p.type) or c.ph("type")
				local desc = c.ph("Description")
				L[#L + 1] = ("%s%s (%s): %s"):format(c.unit, esc(p.name), ty, desc)
			end
			L[#L + 1] = ""
		end
		if c.ret then
			L[#L + 1] = "Returns:"
			local ty = c.ret ~= "" and esc(c.ret) or c.ph("type")
			L[#L + 1] = ("%s%s: %s"):format(c.unit, ty, c.ph("Description"))
			L[#L + 1] = ""
		end
		L[#L + 1] = '"""'
		return table.concat(L, "\n")
	end,
}

----------------------------------------------------------------------

local function lang_at(node, buf)
	local sr, sc, er, ec = node:range()
	local ok, lang = pcall(function()
		return vim.treesitter.get_parser(buf):language_for_range({ sr, sc, er, ec }):lang()
	end)
	return ok and lang or vim.treesitter.language.get_lang(vim.bo[buf].filetype)
end

function M.generate()
	local buf = vim.api.nvim_get_current_buf()
	local ok, node = pcall(vim.treesitter.get_node, { ignore_injections = false })
	if not ok or not node then
		return warn("Treesitter のパーサがありません")
	end

	local lang = lang_at(node, buf)
	local spec = LANGS[lang]
	if not spec then
		return warn("未対応の言語です: " .. tostring(lang))
	end

	-- カーソル位置から親方向にたどって関数ノードを探す
	local fn = node
	while fn and not (spec.types[fn:type()] and (not spec.accept or spec.accept(fn))) do
		fn = fn:parent()
	end
	if not fn then
		return warn("カーソル位置に関数が見つかりません")
	end

	local row, indent
	if spec.inside then
		row, indent = spec.inside(fn, buf)
		if not row then
			return warn("本体が別の行にある関数だけ対応しています")
		end
	else
		row = spec.anchor(fn):range()
		indent = (vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1] or ""):match("^%s*")
	end

	if spec.documented(fn, row, buf) then
		return warn("すでにドキュメントがあります")
	end

	local n = 0
	local ctx = {
		params = spec.params(fn, buf),
		ret = spec.ret(fn, buf),
		unit = vim.bo[buf].expandtab and string.rep(" ", vim.fn.shiftwidth()) or "\t",
		ph = function(default)
			n = n + 1
			return ("${%d:%s}"):format(n, esc(default))
		end,
	}
	local snippet = spec.render(ctx)

	-- インデントだけの空行を作り、そこへ snippet を展開する
	-- (2行目以降のインデントは vim.snippet が現在行に合わせて付ける)
	vim.api.nvim_buf_set_lines(buf, row, row, false, { indent })
	vim.api.nvim_win_set_cursor(0, { row + 1, #indent })
	vim.snippet.expand(snippet)
end

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
	if M.config.keymap then
		vim.keymap.set("n", M.config.keymap, M.generate, { desc = "Generate doc comment" })
	end
	vim.api.nvim_create_user_command("DogeGenerate", M.generate, {})
end

return M
