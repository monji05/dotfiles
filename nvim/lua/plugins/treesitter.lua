return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  event = "UIEnter",
  config = function()
    local ts = require("nvim-treesitter.configs")
    require("treesitter-context").setup()

    ts.setup({
      highlight = {
        enable = true,
        disable = { "vim" },
        additional_vim_regex_highlighting = { "markdown" },
      },
      indent = {
        enable = true,
        disable = {},
      },
      ensure_installed = {
        "tsx",
        "toml",
        "fish",
        "php",
        "json",
        "yaml",
        "css",
        "html",
        "lua",
        "markdown",
        "markdown_inline",
      },
      autotag = {
        enable = true,
      },
      textobjects = {
        select = true,
        lookahead = true,
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>a"] = "@parameter.inner",
          },
        },
        keymaps = {
          -- you can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          -- you can optionally set descriptions to the mappings (used in the desc parameter of
          -- nvim_buf_set_keymap) which plugins like which-key display
          ["ic"] = { query = "@class.inner", desc = "select inner part of a class region" },
          -- you can also use captures from other query groups like `locals.scm`
          ["as"] = { query = "@scope", query_group = "locals", desc = "select language scope" },
        },
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "v",  -- linewise
          ["@class.outer"] = "<c-v>", -- blockwise
        },
        lsp_interop = {
          enable = true,
          border = "none",
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
      },
    })

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
  end,
}
