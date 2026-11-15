-- lua/utils/treesj.lua
local M = {}

M.config = {
	keymaps = { toggle = "<leader>T", split = "<leader>P", join = "<leader>J" },
	-- 言語ごとの末尾カンマ。false / true / function(node_type) -> boolean
	-- 書かれていない言語は true
	trailing = {
		lua = function(t)
			return t == "table_constructor"
		end, -- Lua の引数は末尾カンマ不可
		json = false,
		jsonc = false,
	},
	-- join 時に { } の内側へスペースを入れない言語
	no_brace_pad = { python = true, php = true, json = true, jsonc = true },
}

local CLOSER = { ["("] = ")", ["["] = "]", ["{"] = "}" }
-- 対象外にするノード種別(部分一致)
local DENY = { "block", "body", "statement", "string", "parenthesized", "comment" }

local function denied(t)
	for _, p in ipairs(DENY) do
		if t:find(p, 1, true) then
			return true
		end
	end
	return false
end

local function has_comment(node)
	if node:type():find("comment", 1, true) then
		return true
	end
	for child in node:iter_children() do
		if has_comment(child) then
			return true
		end
	end
	return false
end

--- 「開き括弧, 要素, 区切り, ..., 閉じ括弧」の形のノードなら情報を返す
local function parse(node)
	local n = node:child_count()
	if n < 3 or denied(node:type()) then
		return nil
	end
	local open, close = node:child(0), node:child(n - 1)
	local o = open:type()
	if not CLOSER[o] or close:type() ~= CLOSER[o] then
		return nil
	end

	local items, sep, prev = {}, ",", "open"
	for i = 1, n - 2 do
		local c = node:child(i)
		if c:named() then
			if prev == "item" then
				return nil
			end -- 区切りなしで要素が並ぶ = リストではない
			items[#items + 1] = c
			prev = "item"
		elseif c:type() == "," or c:type() == ";" then
			if prev ~= "item" then
				return nil
			end
			sep = c:type()
			prev = "sep"
		else
			return nil
		end
	end
	if #items == 0 then
		return nil
	end
	return { node = node, open = open, close = close, items = items, sep = sep, o = o }
end

--- カーソル位置から親方向にたどって、条件に合う最初のノードを返す
local function find(pred)
	local ok, node = pcall(vim.treesitter.get_node, { ignore_injections = false })
	if not ok then
		return nil
	end
	while node do
		local info = parse(node)
		if info and pred(info) then
			return info
		end
		node = node:parent()
	end
end

local function is_multiline(info)
	local sr, _, er = info.node:range()
	return sr ~= er
end

local function lang_of(info, buf)
	local sr, sc, er, ec = info.node:range()
	local ok, lang = pcall(function()
		return vim.treesitter.get_parser(buf):language_for_range({ sr, sc, er, ec }):lang()
	end)
	return ok and lang or vim.treesitter.language.get_lang(vim.bo[buf].filetype) or vim.bo[buf].filetype
end

local function trailing(lang, info)
	local f = M.config.trailing[lang]
	if f == nil then
		return true
	end
	if type(f) == "function" then
		return f(info.node:type())
	end
	return f
end

-- join 時に入れ子の要素を1行にまとめる
local function flatten(s)
	s = s:gsub("%s*\n%s*", " ")
	s = s:gsub("([%(%[])%s+", "%1")
	s = s:gsub("%s+([%)%]])", "%1")
	s = s:gsub(",%s*([%)%]])", "%1")
	s = s:gsub(",%s*}", " }")
	return s
end

local function do_split(info, buf)
	local sr = info.node:range()
	local lang = lang_of(info, buf)
	local base = vim.api.nvim_buf_get_lines(buf, sr, sr + 1, false)[1]:match("^%s*")
	local unit = vim.bo[buf].expandtab and string.rep(" ", vim.fn.shiftwidth()) or "\t"

	local lines = { "" }
	local last = #info.items
	for i, item in ipairs(info.items) do
		local text = vim.treesitter.get_node_text(item, buf)
		if i < last or trailing(lang, info) then
			text = text .. info.sep
		end
		lines[#lines + 1] = base .. unit .. text
	end
	lines[#lines + 1] = base

	local _, _, oer, oec = info.open:range()
	local csr, csc = info.close:range()
	vim.api.nvim_buf_set_text(buf, oer, oec, csr, csc, lines)
end

local function do_join(info, buf)
	local lang = lang_of(info, buf)
	local parts = {}
	for _, item in ipairs(info.items) do
		parts[#parts + 1] = flatten(vim.treesitter.get_node_text(item, buf))
	end
	local inner = table.concat(parts, info.sep .. " ")
	if info.o == "{" and not M.config.no_brace_pad[lang] then
		inner = " " .. inner .. " "
	end

	local _, _, oer, oec = info.open:range()
	local csr, csc = info.close:range()
	vim.api.nvim_buf_set_text(buf, oer, oec, csr, csc, { inner })
end

local function run(pred, action)
	local buf = vim.api.nvim_get_current_buf()
	local info = find(pred)
	if not info then
		vim.notify("treesj: 対象のノードが見つかりません", vim.log.levels.WARN)
		return
	end
	if has_comment(info.node) then
		vim.notify("treesj: コメントを含むノードは未対応です", vim.log.levels.WARN)
		return
	end
	action(info, buf)
end

function M.split()
	run(function(i)
		return not is_multiline(i)
	end, do_split)
end

function M.join()
	run(is_multiline, do_join)
end

function M.toggle()
	run(function()
		return true
	end, function(info, buf)
		if is_multiline(info) then
			do_join(info, buf)
		else
			do_split(info, buf)
		end
	end)
end

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
	local k = M.config.keymaps
	if k.toggle then
		vim.keymap.set("n", k.toggle, M.toggle, { desc = "Split/Join toggle" })
	end
	if k.split then
		vim.keymap.set("n", k.split, M.split, { desc = "Split node" })
	end
	if k.join then
		vim.keymap.set("n", k.join, M.join, { desc = "Join node" })
	end
	vim.api.nvim_create_user_command("TSJToggle", M.toggle, {})
	vim.api.nvim_create_user_command("TSJSplit", M.split, {})
	vim.api.nvim_create_user_command("TSJJoin", M.join, {})
end

return M
