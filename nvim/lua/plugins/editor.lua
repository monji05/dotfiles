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
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local fb_actions = telescope.extensions.file_browser.actions
      local actions = require("telescope.actions")
      opts = {
        defaults = {
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
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
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
    "lewis6991/gitsigns.nvim",
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

    -- stylua: ignore start
    map("n", "[c", gs.next_hunk, "Next Hunk")
    map("n", "]c", gs.prev_hunk, "Prev Hunk")
    map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
    map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
    -- map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
    -- map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
    -- map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
    map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
    map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
    map("n", "<leader>ghd", gs.diffthis, "Diff This")
    map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = { "LazyGit" },
  },
}
