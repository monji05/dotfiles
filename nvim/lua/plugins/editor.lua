return {
  {
    -- "telescope.nvim",
    -- dependencies = {
    --   {
    --     "nvim-telescope/telescope-fzf-native.nvim",
    --     build = "make",
    --   },
    --   "nvim-telescope/telescope-file-browser.nvim",
    --   "nvim-telescope/telescope-live-grep-args.nvim",
    -- },
    -- keys = {
    --   {
    --     "<leader>fP",
    --     function()
    --       require("telescope.builtin").find_files({
    --         cwd = require("lazy.core.config").options.root,
    --       })
    --     end,
    --     desc = "Find Plugin File",
    --   },
    --   {
    --     ";f",
    --     function()
    --       local builtin = require("telescope.builtin")
    --       builtin.find_files({
    --         no_ignore = false,
    --         hidden = true,
    --       })
    --     end,
    --     desc = "Lists files in your current working directory, respects .gitignore",
    --   },
    --   {
    --     ";r",
    --     function()
    --       local builtin = require("telescope.builtin")
    --       builtin.live_grep({
    --         additional_args = { "--hidden" },
    --       })
    --     end,
    --     desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
    --   },
    --   {
    --     ";t",
    --     function()
    --       local builtin = require("telescope.builtin")
    --       builtin.help_tags()
    --     end,
    --     desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
    --   },
    --   {
    --     ";;",
    --     function()
    --       local builtin = require("telescope.builtin")
    --       builtin.resume()
    --     end,
    --     desc = "Resume the previous telescope picker",
    --   },
    --   {
    --     ";e",
    --     function()
    --       local builtin = require("telescope.builtin")
    --       builtin.diagnostics()
    --     end,
    --     desc = "Lists Diagnostics for all open buffers or a specific buffer",
    --   },
    --   {
    --     ";s",
    --     function()
    --       local builtin = require("telescope.builtin")
    --       builtin.treesitter()
    --     end,
    --     desc = "Lists Function names, variables, from Treesitter",
    --   },
    --   {
    --     ";g",
    --     function()
    --       local builtin = require("telescope.builtin")
    --       builtin.git_status()
    --     end,
    --     desc = "Lists current changes per file with diff preview and add action. (Multi-selection still WIP)",
    --   },
    --   {
    --     ";b",
    --     function()
    --       local builtin = require("telescope.builtin")
    --       builtin.buffers()
    --     end,
    --     desc = "Lists open buffers in current neovim instance",
    --   },
    --   {
    --     "<leader>f",
    --     function()
    --       local telescope = require("telescope")
    --
    --       local function telescope_buffer_dir()
    --         return vim.fn.expand("%:p:h")
    --       end
    --
    --       telescope.extensions.file_browser.file_browser({
    --         path = "%:p:h",
    --         cwd = telescope_buffer_dir(),
    --         respect_gitignore = false,
    --         hidden = true,
    --         grouped = true,
    --         previewer = false,
    --         initial_mode = "normal",
    --       })
    --     end,
    --     desc = "Open File Browser with the path of the current buffer",
    --   },
    -- },
    -- config = function(_, opts)
    --   local telescope = require("telescope")
    --   local actions = require("telescope.actions")
    --   local fb_actions = require("telescope").extensions.file_browser.actions
    --   local lga_actions = require("telescope-live-grep-args.actions")
    --
    --   opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
    --     wrap_results = true,
    --     layout_strategy = "horizontal",
    --     layout_config = { prompt_position = "top" },
    --     sorting_strategy = "ascending",
    --     winblend = 0,
    --     mappings = {
    --       n = {},
    --     },
    --   })
    --   opts.pickers = {
    --     diagnostics = {
    --       theme = "ivy",
    --       initial_mode = "normal",
    --       layout_config = {
    --         preview_cutoff = 9999,
    --       },
    --     },
    --   }
    --   opts.extensions = {
    --     file_browser = {
    --       theme = "dropdown",
    --       -- disables netrw and use telescope-file-browser in its place
    --       hijack_netrw = true,
    --       mappings = {
    --         -- your custom insert mode mappings
    --         ["n"] = {
    --           -- your custom normal mode mappings
    --           ["N"] = fb_actions.create,
    --           ["h"] = fb_actions.goto_parent_dir,
    --           ["/"] = function()
    --             vim.cmd("startinsert")
    --           end,
    --           ["<C-u>"] = function(prompt_bufnr)
    --             for i = 1, 10 do
    --               actions.move_selection_previous(prompt_bufnr)
    --             end
    --           end,
    --           ["<C-d>"] = function(prompt_bufnr)
    --             for i = 1, 10 do
    --               actions.move_selection_next(prompt_bufnr)
    --             end
    --           end,
    --           ["<PageUp>"] = actions.preview_scrolling_up,
    --           ["<PageDown>"] = actions.preview_scrolling_down,
    --         },
    --       },
    --       live_grep_args = {
    --         auto_quoting = true, -- enable/disable auto-quoting
    --         -- define mappings, e.g.
    --         mappings = { -- extend mappings
    --           i = {
    --             ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
    --             -- freeze the current list and start a fuzzy search in the frozen list
    --             ["<C-space>"] = actions.to_fuzzy_refine,
    --           },
    --         },
    --         -- ... also accepts theme settings, for example:
    --         -- theme = "dropdown", -- use dropdown theme
    --         -- theme = { }, -- use own theme spec
    --         -- layout_config = { mirror=true }, -- mirror preview pane
    --       },
    --     },
    --   }
    --   telescope.load_extension("fzf")
    --   telescope.load_extension("file_browser")
    --   telescope.load_extension("live_grep_args")
    --   telescope.setup(opts)
    -- end,
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "echasnovski/mini.icons" },
    keys = {
      {
        ";f",
        "<Cmd>FzfLua files<CR>",
      },
      {
        ";r",
        "<Cmd>FzfLua live_grep_glob<CR>",
      },
      {
        ";g",
        "<Cmd>FzfLua git_status<CR>",
      },
      {
        "gh",
        "<Cmd>:lua require('fzf-lua').lsp_references({ includeDeclaration = false, ignore_current_line = true })<CR>",
      },
      {
        "gd",
        "<Cmd>FzfLua lsp_definitions<CR>",
      },
      -- {
      --   "<leader>j",
      --   "<Cmd>lua require('fzf-lua').lsp_code_actions({ sync = true })<CR>",
      -- },
    },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({
        grep = {
          rg_glob = true,
          -- first returned string is the new search query
          -- second returned string are (optional) additional rg flags
          -- @return string, string?
          rg_glob_fn = function(query, opts)
            local regex, flags = query:match("^(.-)%s%-%-(.*)$")
            -- If no separator is detected will return the original query
            return (regex or query), flags
          end,
        },
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      {
        "<leader>do",
        "<CMD>DiffviewOpen<CR>",
      },
      {
        "<leader>dc",
        "<CMD>DiffviewClose<CR>",
      },
    },
    config = function()
      -- for solarized.nvim's highlight
      -- https://github.com/sindrets/diffview.nvim/issues/241#issuecomment-1298862577
      vim.cmd([[highlight DiffAdd gui=none guifg=none guibg=#073642]])
      vim.cmd([[highlight DiffChange gui=none guifg=none guibg=#272D43]])
      vim.cmd([[highlight DiffText gui=none guifg=none guibg=#394b70]])
      vim.cmd([[highlight DiffDelete gui=none guifg=none guibg=#3F2D3D]])
      vim.cmd([[highlight DiffviewDiffAddAsDelete guibg=#3f2d3d gui=none guifg=none]])
      vim.cmd([[highlight DiffviewDiffDelete gui=none guifg=#3B4252 guibg=#3F2D3D]])
      vim.cmd([[highlight DiffviewDiffDelete gui=none guifg=#fff guibg=#3F2D3D]])

      -- Left panel
      -- "DiffChange:DiffAddAsDelete",
      -- "DiffText:DiffDeleteText",
      vim.cmd([[highlight DiffAddAsDelete gui=none guifg=none guibg=#3F2D3D]])
      vim.cmd([[highlight DiffDeleteText gui=none guifg=none guibg=#4B1818]])

      -- Right panel
      -- "DiffChange:DiffAdd",
      -- "DiffText:DiffAddText",
      vim.cmd([[highlight DiffAddText gui=none guifg=none guibg=#1C5458]])
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufEnter" },
    opts = {
      chunk = {
        enable = true,
      },
      indent = {
        enable = true,
        -- chars = { "▏" },
        chars = { "│" },
        style = "#383c3d",
      },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = { "LazyGit" },
  },
  {
    "f-person/git-blame.nvim",
    cmd = { "GitBlameCopyCommitURL", "GitBlameOpenCommitURL", "GitBlameCopyFileURL", "GitBlameToggle" },
    keys = {
      {
        "<leader>gu",
        "<CMD>GitBlameCopyCommitURL<CR>",
        desc = "copy commit URL",
      },
      {
        "<leader>bf",
        "<CMD>GitBlameCopyFileURL<CR>",
        desc = "copy file URL",
      },
    },
    opts = {
      enabled = false,
    },
  },
  {
    -- very useful join, split word in bracket, function
    "Wansmer/treesj",
    desc = "Toggle Treesitter Join",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    opts = { use_default_keymaps = false },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]c", gs.next_hunk, "Next Hunk")
        map("n", "[c", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>h", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  {
    "echasnovski/mini.files",
    version = "*",
    opts = {
      windows = {
        preview = true,
        width_focus = 80,
        width_preview = 80,
      },
    },
  },
}
