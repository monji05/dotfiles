-- icons used by other plugins
-- stylua: ignore
local M = {
  misc = {
    dots = "󰇘",
  },
  ft = {
    octo = " ",
    gh = " ",
    ["markdown.gh"] = " ",
  },
  dap = {
    Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint          = " ",
    BreakpointCondition = " ",
    BreakpointRejected  = { " ", "DiagnosticError" },
    LogPoint            = ".>",
  },
  diagnostics = {
    Error = " ",
    Warn  = " ",
    Hint  = " ",
    Info  = " ",
  },
  git = {
    added    = " ",
    modified = " ",
    removed  = " ",
  },
  kinds = {
    Array         = " ",
    Boolean       = "󰨙 ",
    Class         = " ",
    Codeium       = "󰘦 ",
    Color         = " ",
    Control       = " ",
    Collapsed     = " ",
    Constant      = "󰏿 ",
    Constructor   = " ",
    Copilot       = " ",
    Enum          = " ",
    EnumMember    = " ",
    Event         = " ",
    Field         = " ",
    File          = " ",
    Folder        = " ",
    Function      = "󰊕 ",
    Interface     = " ",
    Key           = " ",
    Keyword       = " ",
    Method        = "󰊕 ",
    Module        = " ",
    Namespace     = "󰦮 ",
    Null          = " ",
    Number        = "󰎠 ",
    Object        = " ",
    Operator      = " ",
    Package       = " ",
    Property      = " ",
    Reference     = " ",
    Snippet       = "󱄽 ",
    String        = " ",
    Struct        = "󰆼 ",
    Supermaven    = " ",
    TabNine       = "󰏚 ",
    Text          = " ",
    TypeParameter = " ",
    Unit          = " ",
    Value         = " ",
    Variable      = "󰀫 ",
  },
}

local function ch(n)
	return vim.fn.nr2char(n)
end

M.default = { ch(0xf15b), "#6d8086" } --
M.folder = { ch(0xf07b), "#7ebae4" } --

-- ファイル名が完全一致するもの(小文字で比較)
local by_name = {
	[".gitignore"] = { ch(0xe702), "#f1502f" },
	[".gitattributes"] = { ch(0xe702), "#f1502f" },
	[".gitmodules"] = { ch(0xe702), "#f1502f" },
	[".env"] = { ch(0xf462), "#faf743" },
	["dockerfile"] = { ch(0xf308), "#458ee6" },
	["docker-compose.yml"] = { ch(0xf308), "#458ee6" },
	["makefile"] = { ch(0xe779), "#6d8086" },
	["package.json"] = { ch(0xe71e), "#e8274b" },
	["composer.json"] = { ch(0xe73d), "#a074c4" },
	["init.lua"] = { ch(0xe620), "#51a0cf" },
	["readme.md"] = { ch(0xf48a), "#ffffff" },
	["license"] = { ch(0xf15c), "#d0bf41" },
}

-- vim.filetype のファイルタイプごとのアイコンと色
local by_ft = {
	lua = { ch(0xe620), "#51a0cf" },
	vim = { ch(0xe62b), "#019833" },
	php = { ch(0xe73d), "#a074c4" },
	blade = { ch(0xe73d), "#f05340" },
	javascript = { ch(0xe74e), "#cbcb41" },
	typescript = { ch(0xe628), "#519aba" },
	javascriptreact = { ch(0xe7ba), "#20c2e3" },
	typescriptreact = { ch(0xe7ba), "#1354bf" },
	vue = { ch(0xe6a0), "#8dc149" },
	svelte = { ch(0xe697), "#ff3e00" },
	json = { ch(0xe60b), "#cbcb41" },
	jsonc = { ch(0xe60b), "#cbcb41" },
	yaml = { ch(0xe6a8), "#6d8086" },
	toml = { ch(0xe6b2), "#9c4221" },
	markdown = { ch(0xe73e), "#519aba" },
	html = { ch(0xe736), "#e44d26" },
	css = { ch(0xe749), "#42a5f5" },
	scss = { ch(0xe749), "#f55385" },
	python = { ch(0xe606), "#ffbc03" },
	ruby = { ch(0xe791), "#701516" },
	rust = { ch(0xe7a8), "#dea584" },
	go = { ch(0xe627), "#519aba" },
	c = { ch(0xe61e), "#599eff" },
	cpp = { ch(0xe61d), "#519aba" },
	java = { ch(0xe738), "#cc3e44" },
	sh = { ch(0xf489), "#4d5a5e" },
	bash = { ch(0xf489), "#89e051" },
	zsh = { ch(0xf489), "#89e051" },
	sql = { ch(0xe706), "#dad8d8" },
	xml = { ch(0xe619), "#e37933" },
	gitcommit = { ch(0xe702), "#f1502f" },
	gitconfig = { ch(0xe702), "#f1502f" },
	dockerfile = { ch(0xf308), "#458ee6" },
	text = { ch(0xf15c), "#89e051" },
	help = { ch(0xf059), "#519aba" },
	query = { ch(0xf0e8), "#90a850" },
}

-- ファイルタイプが付かないものだけ拡張子で補う
local by_ext = {
	png = { ch(0xf1c5), "#a074c4" },
	jpg = { ch(0xf1c5), "#a074c4" },
	jpeg = { ch(0xf1c5), "#a074c4" },
	gif = { ch(0xf1c5), "#a074c4" },
	svg = { ch(0xf1c5), "#ffb13b" },
	webp = { ch(0xf1c5), "#a074c4" },
	lock = { ch(0xf023), "#bbbbbb" },
	zip = { ch(0xf1c6), "#eca517" },
	pdf = { ch(0xf1c1), "#b30b00" },
}

--- { icon, color } を返す内部関数。見つからなければ M.default
local function lookup(name, ft)
	local base = vim.fs.basename(name or ""):lower()
	if by_name[base] then
		return by_name[base]
	end

	if not ft or ft == "" then
		ft = base ~= "" and vim.filetype.match({ filename = base }) or nil
	end
	if ft and by_ft[ft] then
		return by_ft[ft]
	end

	local ext = base:match("%.([^.]+)$")
	return (ext and by_ext[ext]) or M.default
end

--- アイコンだけ返す(ft を渡すとそれを優先。バッファならこちらが確実)
function M.file_icon(name, ft)
	return lookup(name, ft)[1]
end

--- devicons の get_icon_color と同じ形: icon, "#rrggbb"
function M.file_icon_color(name, ft)
	local e = lookup(name, ft)
	return e[1], e[2]
end

--- icon, ハイライトグループ名 を返す。グループは初回に自動作成する
--- bg を渡すと背景色も付ける(statusline のように背景が決まっている場所用)
local hl_cache = {}
function M.file_icon_hl(name, ft, bg)
	local e = lookup(name, ft)
	local key = e[2]:sub(2) .. (bg and ("_" .. bg:sub(2)) or "")
	local group = "FileIcon_" .. key
	if not hl_cache[group] then
		vim.api.nvim_set_hl(0, group, { fg = e[2], bg = bg })
		hl_cache[group] = true
	end
	return e[1], group
end

--- filetype だけから引く版(statusline 右側用)
function M.ft_icon(ft)
	local e = by_ft[ft]
	return e and e[1] or nil
end

function M.ft_icon_hl(ft, bg)
	local e = by_ft[ft]
	if not e then
		return nil
	end
	return M.file_icon_hl(nil, ft, bg)
end

-- ColorScheme 変更でハイライトが消えるので作り直す
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("UtilsIconsHl", { clear = true }),
	callback = function()
		hl_cache = {}
	end,
})

return M
