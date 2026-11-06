local gh = function(repo)
  return "https://github.com/" .. repo
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind == "delete" then
      return
    end
    if name == "nvim-treesitter" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    elseif name == "vim-doge" then
      if not ev.data.active then
        vim.cmd.packadd("vim-doge")
      end
      vim.cmd("call doge#install()")
    end
  end,
})

vim.pack.add({
  -- libraries
  gh("nvim-lua/plenary.nvim"),
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
  gh("folke/trouble.nvim"),
  gh("nvim-lualine/lualine.nvim"),

  -- coding
  { src = gh("altermo/ultimate-autopair.nvim"), version = "v0.6" },
  gh("numToStr/Comment.nvim"),
  gh("nvim-mini/mini.surround"),
  gh("Wansmer/treesj"),
  gh("chrisgrieser/nvim-genghis"),
  gh("stevearc/oil.nvim"),
  gh("folke/persistence.nvim"),
  gh("kkoomen/vim-doge"),
  gh("stevearc/conform.nvim"),

  -- treesitter
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  gh("nvim-treesitter/nvim-treesitter-context"),

  -- LSP / completion / format / lint
  gh("mason-org/mason.nvim"),
  gh("neovim/nvim-lspconfig"),
  gh("nvimdev/lspsaga.nvim"),
  { src = gh("saghen/blink.cmp"), version = vim.version.range("*") },
  gh("mfussenegger/nvim-lint"),
  gh("nvimtools/none-ls.nvim"),

  -- git
  gh("lewis6991/gitsigns.nvim"),
  gh("esmuellert/codediff.nvim"),
  { src = "https://github.com/craftzdog/mini.diff", version = "feat/grouping" },

  -- docs / markup / preview
  gh("MeanderingProgrammer/render-markdown.nvim"),
})

local setups = {
  ["mini.icons"] = {},
  ["nvim-web-devicons"] = {},
  ["colorizer"] = {},
  ["persistence"] = {},
}

require("config.plugins.ui-colorscheme")
require("config.plugins.ui")
require("config.plugins.snacks")
require("config.plugins.editor")
require("config.plugins.lsp")
require("config.plugins.coding")
require("config.plugins.codediff")
require("config.plugins.util")
require("config.plugins.diagnostic")

for mod, opts in pairs(setups) do
  local ok, m = pcall(require, mod)
  if ok and type(m) == "table" and m.setup then
    local ok2, err = pcall(m.setup, opts)
    if not ok2 then
      vim.notify(("setup(%s) failed: %s"):format(mod, err), vim.log.levels.WARN)
    end
  end
end
