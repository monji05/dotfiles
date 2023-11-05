local ts = require("nvim-treesitter.configs")
require("treesitter-context").setup()

ts.setup({
  highlight = {
    enable = true,
    disable = { "vim" },
    additional_vim_regex_highlighting = { "markdown" },
  },
  indent = {
    enable = false,
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
    "norg",
    -- "norg_meta",
    "kdl"
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
        ["<leader>A"] = "@parameter.inner",
      }

    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    keymaps = {
      -- you can use the capture groups defined in textobjects.scm
      ["aa"] = "@parameter.outer",
      ["ia"] = "@parameter.inner",
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
      ["@function.outer"] = "V",  -- linewise
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
parser_config.plantuml = {
  install_info = {
    url = "https://github.com/lyndsysimon/tree-sitter-plantuml",
    files = { "src/parser.c" },
    -- optional entries:
    branch = "main",                        -- default branch in case of git repo if different from master
    generate_requires_npm = false,          -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "puml"
}
