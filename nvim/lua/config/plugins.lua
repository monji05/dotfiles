-- lua/config/plugins.lua -- vim.pack (Neovim 0.12+) replacement for lazy.nvim
--
-- 1) PackChanged hooks   (must come BEFORE vim.pack.add)
-- 2) vim.pack.add        (install + load, in order)
-- 3) setup() calls       (replaces lazy's `opts` / `config`)

local gh = function(repo) return "https://github.com/" .. repo end

-- ---------------------------------------------------------------- 1) hooks
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind == "delete" then return end
    if name == "nvim-treesitter" then
      -- plugin isn't on the runtimepath yet right after install/update
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    elseif name == "vim-doge" then
      if not ev.data.active then vim.cmd.packadd("vim-doge") end
      vim.cmd("call doge#install()")
    end
  end,
})

-- ------------------------------------------------------------- 2) install
-- Dependencies come first so they are on the runtimepath when needed.
vim.pack.add({
  -- libraries
  gh("nvim-lua/plenary.nvim"),
  gh("nvim-neotest/nvim-nio"),
  gh("nvim-mini/mini.icons"),
  gh("nvim-tree/nvim-web-devicons"),

  -- colorscheme
  gh("craftzdog/solarized-osaka.nvim"),

  -- UI
  gh("folke/snacks.nvim"),
  gh("b0o/incline.nvim"),
  gh("rachartier/tiny-inline-diagnostic.nvim"),
  gh("shellRaining/hlchunk.nvim"),
  gh("m-demare/hlargs.nvim"),
  gh("NvChad/nvim-colorizer.lua"),
  gh("nacro90/numb.nvim"),
  gh("xzbdmw/colorful-menu.nvim"),
  gh("emmanueltouzery/key-menu.nvim"),
  gh("kevinhwang91/nvim-bqf"),
  gh("stevearc/quicker.nvim"),
  gh("folke/trouble.nvim"),
  gh("WilliamHsieh/overlook.nvim"),

  -- editing
  gh("altermo/ultimate-autopair.nvim"),
  gh("numToStr/Comment.nvim"),
  gh("nvim-mini/mini.surround"),
  gh("monaqa/dial.nvim"),
  gh("Wansmer/treesj"),
  gh("chrisgrieser/nvim-genghis"),
  gh("stevearc/oil.nvim"),
  gh("folke/persistence.nvim"),

  -- treesitter
  -- lsp.lua starts treesitter by hand (vim.treesitter.start), i.e. the `main` branch
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  gh("nvim-treesitter/nvim-treesitter-context"),

  -- LSP / completion / format / lint
  gh("mason-org/mason.nvim"),
  gh("neovim/nvim-lspconfig"),
  gh("nvimdev/lspsaga.nvim"),
  { src = gh("saghen/blink.cmp"), version = vim.version.range("*") },
  gh("stevearc/conform.nvim"),
  gh("mfussenegger/nvim-lint"),
  gh("nvimtools/none-ls.nvim"),

  -- git
  gh("lewis6991/gitsigns.nvim"),
  gh("pwntester/octo.nvim"),
  gh("esmuellert/codediff.nvim"),
  -- TODO: mini.diff from branch feat/grouping (confirm repo, see notes)
  -- { src = gh("nvim-mini/mini.nvim"), version = "feat/grouping" },

  -- test
  gh("nvim-neotest/neotest"),
  gh("olimorris/neotest-phpunit"),

  -- docs / markup / preview
  gh("MeanderingProgrammer/render-markdown.nvim"),
  gh("wallpants/github-preview.nvim"),
  gh("mpas/marp-nvim"),
  gh("aklt/plantuml-syntax"),
  gh("weirongxu/plantuml-previewer.vim"),
  gh("tyru/open-browser.vim"),
  gh("kkoomen/vim-doge"),
})

-- ------------------------------------------------------------- 3) setup()
-- lazy.nvim called setup() automatically for specs that had `opts`.
-- Here every plugin gets a default setup(); replace `{}` with the `opts`
-- from the old lua/plugins/*.lua spec. Missing modules are skipped silently.
local setups = {
  ["mini.icons"] = {},
  ["nvim-web-devicons"] = {},
  ["incline"] = {},
  ["colorizer"] = {},
  ["numb"] = {},
  ["quicker"] = {},
  ["trouble"] = {},
  ["overlook"] = {},
  ["ultimate-autopair"] = {},
  ["Comment"] = {},
  ["mini.surround"] = {},
  ["oil"] = {},
  ["persistence"] = {},
  ["treesitter-context"] = {},
  ["conform"] = {},
  ["octo"] = {},
  ["render-markdown"] = {},
}

-- colorscheme + hlargs first (was `priority = 1000`), then snacks (also priority 1000)
require("config.plugins.ui-colorscheme")
require("config.plugins.snacks")
require("config.plugins.editor")
require("config.plugins.lsp")
require("config.plugins.codediff")

for mod, opts in pairs(setups) do
  local ok, m = pcall(require, mod)
  if ok and type(m) == "table" and m.setup then
    local ok2, err = pcall(m.setup, opts)
    if not ok2 then
      vim.notify(("setup(%s) failed: %s"):format(mod, err), vim.log.levels.WARN)
    end
  end
end

-- Not covered above, port from your old specs by hand:
--   neotest (+ neotest-phpunit adapter), none-ls sources, nvim-lint
--   linters_by_ft, dial.nvim keymaps, github-preview,
--   nvim-treesitter (ensure_installed / highlight)
