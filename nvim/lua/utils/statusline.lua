-- lua/statusline.lua
local M = {}
local uv = vim.uv or vim.loop

-- solarized dark パレット
local C = {
	base03 = "#002b36",
	base02 = "#073642",
	base0 = "#839496",
	base1 = "#93a1a1",
	yellow = "#b58900",
	red = "#dc322f",
	magenta = "#d33682",
	blue = "#268bd2",
	cyan = "#2aa198",
	green = "#859900",
}

local function ch(n)
	return vim.fn.nr2char(n)
end
local I = {
	rarrow = ch(0xe0b0), --
	rthin = ch(0xe0b1), --
	larrow = ch(0xe0b2), --
	lthin = ch(0xe0b3), --
	branch = ch(0xe0a0), --
	linux = ch(0xf17c), --
	apple = ch(0xf179), --
	win = ch(0xf17a), --
	lua = ch(0xe620), --
}
local DIAG = {
	{ sev = vim.diagnostic.severity.ERROR, icon = "✘", hl = "SlDiagE" },
	{ sev = vim.diagnostic.severity.WARN, icon = "⚠", hl = "SlDiagW" },
	{ sev = vim.diagnostic.severity.INFO, icon = "ℹ", hl = "SlDiagI" },
	{ sev = vim.diagnostic.severity.HINT, icon = "⚑", hl = "SlDiagH" },
}
-- モード: 表示名と色の系統
local MODE_NAME = {
	n = "NORMAL",
	i = "INSERT",
	v = "VISUAL",
	V = "V-LINE",
	["\22"] = "V-BLOCK",
	c = "COMMAND",
	R = "REPLACE",
	s = "SELECT",
	S = "S-LINE",
	["\19"] = "S-BLOCK",
	t = "TERMINAL",
}
local MODE_HL = {
	n = "n",
	i = "i",
	v = "v",
	V = "v",
	["\22"] = "v",
	s = "v",
	S = "v",
	["\19"] = "v",
	c = "c",
	R = "r",
	t = "t",
}
local MODE_COLOR = {
	n = C.blue,
	i = C.green,
	v = C.magenta,
	c = C.yellow,
	r = C.red,
	t = C.cyan,
}

local function set_hl()
	local set = vim.api.nvim_set_hl
	for k, col in pairs(MODE_COLOR) do
		set(0, "SlA_" .. k, { fg = C.base03, bg = col, bold = true })
		set(0, "SlAB_" .. k, { fg = col, bg = C.base1 }) -- a -> b / y -> z の矢印
		set(0, "SlAC_" .. k, { fg = col, bg = C.base02 }) -- a -> c の矢印(b無し時)
	end
	set(0, "SlB", { fg = C.base03, bg = C.base1 })
	set(0, "SlBSep", { fg = C.base1, bg = C.base02 })
	set(0, "SlC", { fg = C.base0, bg = C.base02 })
	set(0, "SlCSub", { fg = C.base0, bg = C.base02 })
	set(0, "SlLsp", { fg = C.green, bg = C.base02 })
	set(0, "SlDiagE", { fg = C.red, bg = C.base02 })
	set(0, "SlDiagW", { fg = C.yellow, bg = C.base02 })
	set(0, "SlDiagI", { fg = C.blue, bg = C.base02 })
	set(0, "SlDiagH", { fg = C.cyan, bg = C.base02 })
	set(0, "SlInactive", { fg = C.base0, bg = C.base02 })
end

local function esc(s)
	return (s:gsub("%%", "%%%%"))
end

-- Git ブランチ (.git/HEAD を直接読む。バッファ変数にキャッシュ)
local function read_branch(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr)
	local dir = name ~= "" and vim.fs.dirname(name) or uv.cwd()
	local git = vim.fs.find(".git", { upward = true, path = dir })[1]
	if not git then
		return ""
	end
	local stat = uv.fs_stat(git)
	if stat and stat.type == "file" then -- worktree / submodule
		local f = io.open(git)
		local line = f and f:read("*l")
		if f then
			f:close()
		end
		local p = line and line:match("^gitdir:%s*(.+)")
		if not p then
			return ""
		end
		if not (p:match("^/") or p:match("^%a:")) then
			p = vim.fs.joinpath(vim.fs.dirname(git), p)
		end
		git = p
	end
	local f = io.open(git .. "/HEAD")
	if not f then
		return ""
	end
	local head = f:read("*l") or ""
	f:close()
	return head:match("^ref: refs/heads/(.+)") or head:sub(1, 7)
end

local function update_branch(args)
	local bufnr = args.buf
	if vim.bo[bufnr].buftype ~= "" then
		return
	end
	vim.b[bufnr].sl_branch = read_branch(bufnr)
end

local function diagnostics(bufnr)
	local counts = vim.diagnostic.count(bufnr)
	local out = {}
	for _, d in ipairs(DIAG) do
		local n = counts[d.sev]
		if n and n > 0 then
			table.insert(out, string.format("%%#%s#%s%d", d.hl, d.icon, n))
		end
	end
	return table.concat(out, " ")
end

local function filename(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr)
	name = name == "" and "[No Name]" or vim.fn.fnamemodify(name, ":.")
	if vim.bo[bufnr].modified then
		name = name .. " [+]"
	end
	if vim.bo[bufnr].readonly then
		name = name .. " [RO]"
	end
	return esc(name)
end

local function lsp_progress()
	local s = vim.lsp.status()
	if #s > 40 then
		s = s:sub(1, 40) .. "…"
	end
	return esc(s)
end

function M.render()
	local winid = vim.g.statusline_winid
	local bufnr = vim.api.nvim_win_get_buf(winid)

	-- 非アクティブウィンドウ
	if winid ~= vim.api.nvim_get_current_win() then
		return "%#SlInactive# " .. filename(bufnr) .. " %=%l:%c "
	end

	local raw = vim.api.nvim_get_mode().mode:sub(1, 1)
	local key = MODE_HL[raw] and raw or "n"
	local m = MODE_HL[key]

	-- ===== 左 =====
	local branch = vim.b[bufnr].sl_branch or ""
	local left = { string.format("%%#SlA_%s# %s ", m, MODE_NAME[key]) }
	if branch ~= "" then
		table.insert(
			left,
			string.format("%%#SlAB_%s#%s%%#SlB# %s %s %%#SlBSep#%s", m, I.rarrow, I.branch, esc(branch), I.rarrow)
		)
	else
		table.insert(left, string.format("%%#SlAC_%s#%s", m, I.rarrow))
	end
	table.insert(left, "%#SlC# ")
	local diag = diagnostics(bufnr)
	if diag ~= "" then
		table.insert(left, diag .. "%#SlC# ")
	end
	table.insert(left, filename(bufnr))
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	if #clients > 0 then
		local names = {}
		for _, c in ipairs(clients) do
			table.insert(names, c.name)
		end
		table.insert(left, " %#SlCSub#" .. I.rthin .. " %#SlLsp#" .. esc(table.concat(names, ",")) .. "%#SlC#")
	end
	local prog = lsp_progress()
	if prog ~= "" then
		table.insert(left, "  " .. prog)
	end
	return table.concat(left)
end

function M.setup()
	set_hl()
	vim.o.statusline = "%!v:lua.require'utils.statusline'.render()"
	-- vim.o.laststatus = 3 -- 全ウィンドウで1本にしたい場合

	local group = vim.api.nvim_create_augroup("UserStatusline", { clear = true })
	vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = set_hl })
	vim.api.nvim_create_autocmd(
		{ "BufEnter", "BufWritePost", "FocusGained", "DirChanged" },
		{ group = group, callback = update_branch }
	)
	vim.api.nvim_create_autocmd({ "LspProgress", "LspAttach", "LspDetach", "DiagnosticChanged" }, {
		group = group,
		callback = function()
			vim.cmd.redrawstatus()
		end,
	})
end

return M
