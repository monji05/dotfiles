return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-z.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "dawsers/telescope-file-history.nvim",
      "smartpde/telescope-recent-files",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    keys = {
      {
        ";f",
        "<Cmd>Telescope find_files<CR>",
      },
      {
        ";r",
        "<Cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      },
      {
        "<leader>f",
        ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
      },
      {
        ";;",
        "<Cmd>Telescope resume<CR>",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local fb_actions = telescope.extensions.file_browser.actions
      local actions = require("telescope.actions")
      local my_icons = require("config.icons")
      opts = {
        defaults = {
          prompt_prefix = my_icons.telescope.prompt,
          selection_caret = my_icons.telescope.selection_caret,
          mappings = {
            i = {
              ["<C-o>"] = actions.select_tab,
              ["<C-q>"] = actions.close,
            },
            n = {
              ["o"] = actions.select_tab,
              ["q"] = actions.close,
            },
          },
        },
        extensions = {
          file_browser = {
            initial_mode = "normal",
            theme = "ivy",
            display_stat = { date = false, size = false },
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            prompt_path = true,
            mappings = {
              -- your custom insert mode mappings
              ["i"] = {
                ["<C-w>"] = function()
                  vim.cmd("normal vbd")
                end,
                ["<C-o>"] = actions.select_tab,
              },
              ["n"] = {
                -- your custom normal mode mappings
                ["n"] = fb_actions.create,
                ["o"] = actions.select_tab,
                ["h"] = fb_actions.goto_parent_dir,
                ["H"] = fb_actions.toggle_hidden,
                ["/"] = function()
                  vim.cmd("startinsert")
                end,
              },
            },
          },
        },
      }
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
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
      -- vim.cmd([[highlight DiffChange gui=none guifg=none guibg=#272D43]])
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
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = true,
    ft = { "lua", "php", "html", "css", "js", "jsx", "ts", "tsx" },
    opts = {
      indent = {
        char = "▏",
        tab_char = "▏",
      },
      whitespace = {
        -- remove_blankline_trail = false,
        remove_blankline_trail = true,
      },
      scope = {
        -- don't be true! tree-sitter cause error!
        enabled = false,
      },
      exclude = {
        filetypes = {
          "help",
          "startify",
          "dashboard",
          "packer",
          "neogitstatus",
          "NvimTree",
          "Trouble",
        },
        buftypes = {
          "terminal",
          "nofile",
        },
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    config = function()
      require("mini.indentscope").setup({
        symbol = "▏",
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Textobjects
          object_scope = "ii",
          object_scope_with_border = "ai",

          -- Motions (jump to respective border line; if not present - body line)
          goto_top = "[i",
          goto_bottom = "]i",
        },
      })
    end,
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
        map("n", "<leader>b", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  {
    "johnfrankmorgan/whitespace.nvim",
    config = function()
      require("whitespace-nvim").setup({
        -- configuration options and their defaults

        -- `highlight` configures which highlight is used to display
        -- trailing whitespace
        highlight = "DiffDelete",

        -- `ignored_filetypes` configures which filetypes to ignore when
        -- displaying trailing whitespace
        ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "dashboard" },

        -- `ignore_terminal` configures whether to ignore terminal buffers
        ignore_terminal = true,

        -- `return_cursor` configures if cursor should return to previous
        -- position after trimming whitespace
        return_cursor = true,
      })
    end,
  },
}
