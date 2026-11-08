-- lua/utils/pack_ui.lua
local M = {}

local state = {
	buf = nil,
	win = nil,
	plugins = {}, -- vim.pack.get() の結果(名前順)
	view = {}, -- 画面に表示している順序(行番号 -> プラグインの対応に使う)
	behind = {}, -- name -> n(遅れているコミット数) / 0 / -1(失敗) / -2(version固定)
	rev = {}, -- name -> short hash
	checking = false,
	done = 0,
	total = 0,
}

local HEADER_LINES = 3

local function load_plugins()
	state.plugins = vim.pack.get(nil, { info = false })
	table.sort(state.plugins, function(a, b)
		return a.spec.name:lower() < b.spec.name:lower()
	end)
end

local function git(path, args, cb)
	vim.system(vim.list_extend({ "git", "-C", path }, args), { text = true }, function(res)
		vim.schedule(function()
			cb(res)
		end)
	end)
end

-- 1: 更新あり / 2: 使用中(更新なし・未判定) / 3: 未使用(削除候補)
local function rank(p)
	if not p.active then
		return 3
	end
	if (state.behind[p.spec.name] or 0) > 0 then
		return 1
	end
	return 2
end

local function build_view()
	local view = vim.list_slice(state.plugins)
	table.sort(view, function(a, b)
		local ra, rb = rank(a), rank(b)
		if ra ~= rb then
			return ra < rb
		end
		if ra == 1 then
			-- 更新あり同士は遅れているコミット数が多い順
			local ba, bb = state.behind[a.spec.name], state.behind[b.spec.name]
			if ba ~= bb then
				return ba > bb
			end
		end
		return a.spec.name:lower() < b.spec.name:lower()
	end)
	return view
end

local function render()
	if not (state.buf and vim.api.nvim_buf_is_valid(state.buf)) then
		return
	end

	-- 並び替え前にカーソル下のプラグイン名を覚えておき、並び替え後も追従させる
	local cursor_name
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		local row = vim.api.nvim_win_get_cursor(state.win)[1]
		local old = state.view[row - HEADER_LINES]
		cursor_name = old and old.spec.name
	end

	local view = build_view()
	state.view = view

	local updates, unused = 0, 0
	for _, p in ipairs(view) do
		if not p.active then
			unused = unused + 1
		end
		if rank(p) == 1 then
			updates = updates + 1
		end
	end

	local status = state.checking and string.format("checking... %d/%d", state.done, state.total) or ""
	local lines = {
		string.format(" vim.pack   Installed: %d   Updates: %d   Unused: %d   %s", #view, updates, unused, status),
		" [U] check  [u] update  [d] delete under cursor  [D] delete all unused  [r] reload  [q] close",
		string.rep("─", 90),
	}
	local hls = { { 0, "Title" }, { 1, "Comment" }, { 2, "Comment" } }

	for _, p in ipairs(view) do
		local name = p.spec.name
		local b = state.behind[name]
		local text, hl
		if not p.active then
			text, hl = "unused (delete candidate)", "DiagnosticHint"
		elseif b == nil then
			text, hl = "", "Comment"
		elseif b == -1 then
			text, hl = "check failed", "DiagnosticError"
		elseif b == -2 then
			text, hl = "version pinned (use vim.pack.update)", "Comment"
		elseif b == 0 then
			text, hl = "up to date", "DiagnosticOk"
		else
			text, hl = "↑ " .. b .. " commits behind", "DiagnosticWarn"
		end

		local icon = p.active and "●" or "○"
		local rev = state.rev[name] or (p.rev or ""):sub(1, 8)
		lines[#lines + 1] = string.format(" %s %-35s %-9s %s", icon, name, rev, text)
		if text ~= "" and b ~= 0 or not p.active then
			hls[#hls + 1] = { #lines - 1, hl }
		end
	end

	vim.bo[state.buf].modifiable = true
	vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
	vim.bo[state.buf].modifiable = false

	local ns = vim.api.nvim_create_namespace("pack_ui")
	vim.api.nvim_buf_clear_namespace(state.buf, ns, 0, -1)
	for _, h in ipairs(hls) do
		vim.api.nvim_buf_set_extmark(state.buf, ns, h[1], 0, { line_hl_group = h[2] })
	end

	-- カーソルを同じプラグインの行へ戻す
	if cursor_name and state.win and vim.api.nvim_win_is_valid(state.win) then
		for i, p in ipairs(view) do
			if p.spec.name == cursor_name then
				pcall(vim.api.nvim_win_set_cursor, state.win, { i + HEADER_LINES, 0 })
				break
			end
		end
	end
end

function M.check()
	if state.checking then
		return
	end
	load_plugins()
	local plugins = state.plugins
	state.behind, state.rev = {}, {}
	state.done, state.total, state.checking = 0, #plugins, #plugins > 0

	local function finish()
		state.done = state.done + 1
		if state.done >= state.total then
			state.checking = false
		end
		render()
	end

	render()

	for _, p in ipairs(plugins) do
		local name, v = p.spec.name, p.spec.version

		git(p.path, { "rev-parse", "--short=8", "HEAD" }, function(r)
			if r.code == 0 then
				state.rev[name] = vim.trim(r.stdout)
			end
		end)

		if not p.active then
			finish() -- 未使用は fetch しない
		elseif v ~= nil and type(v) ~= "string" then
			state.behind[name] = -2 -- semver range など
			finish()
		else
			local ref = v and ("origin/" .. v) or "origin/HEAD"
			git(p.path, { "fetch", "--quiet", "origin" }, function(r1)
				if r1.code ~= 0 then
					state.behind[name] = -1
					return finish()
				end
				git(p.path, { "rev-list", "--count", "HEAD.." .. ref }, function(r2)
					state.behind[name] = (r2.code == 0) and tonumber(vim.trim(r2.stdout)) or -1
					finish()
				end)
			end)
		end
	end
end

local function delete(names, force)
	if #names == 0 then
		vim.notify("No plugins to delete", vim.log.levels.INFO)
		return
	end
	local msg = string.format("Delete %d plugin(s)?\n\n%s", #names, table.concat(names, "\n"))
	if vim.fn.confirm(msg, "&Yes\n&No", 2) ~= 1 then
		return
	end

	local ok, err = pcall(vim.pack.del, names, { force = force })
	if not ok then
		vim.notify("vim.pack.del failed: " .. tostring(err), vim.log.levels.ERROR)
	end
	load_plugins()
	render()
end

function M.open()
	state.view = {}

	state.buf = vim.api.nvim_create_buf(false, true)
	vim.bo[state.buf].bufhidden = "wipe"
	vim.bo[state.buf].filetype = "packui"

	local w, h = math.floor(vim.o.columns * 0.75), math.floor(vim.o.lines * 0.7)
	state.win = vim.api.nvim_open_win(state.buf, true, {
		relative = "editor",
		width = w,
		height = h,
		row = math.floor((vim.o.lines - h) / 2),
		col = math.floor((vim.o.columns - w) / 2),
		style = "minimal",
		border = "rounded",
		title = " Plugins ",
		title_pos = "center",
	})
	vim.wo[state.win].cursorline = true

	local function close()
		if state.win and vim.api.nvim_win_is_valid(state.win) then
			vim.api.nvim_win_close(state.win, true)
		end
	end

	local map = function(k, f)
		vim.keymap.set("n", k, f, { buffer = state.buf, nowait = true, silent = true })
	end
	map("q", close)
	map("<Esc>", close)
	map("r", function()
		load_plugins()
		render()
	end)
	map("U", M.check)
	map("u", function()
		close()
		vim.pack.update()
	end)

	-- カーソル行のプラグインを削除(使用中なら force)
	map("d", function()
		local row = vim.api.nvim_win_get_cursor(state.win)[1]
		local p = state.view[row - HEADER_LINES] -- 表示順で引く
		if not p then
			return
		end
		delete({ p.spec.name }, p.active)
	end)

	-- 未使用をまとめて削除
	map("D", function()
		local names = {}
		for _, p in ipairs(state.plugins) do
			if not p.active then
				names[#names + 1] = p.spec.name
			end
		end
		delete(names, false)
	end)

	load_plugins()
	render()
	M.check()
end

return M
