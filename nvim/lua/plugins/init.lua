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
  gh("rachartier/tiny-cmdline.nvim"),

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

require("plugins.ui-colorscheme")
require("plugins.ui")
require("plugins.snacks")
require("plugins.editor")
require("plugins.lsp")
require("plugins.coding")
require("plugins.util")
require("plugins.diagnostic")
require("plugins.keymaps")
