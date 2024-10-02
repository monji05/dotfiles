return {
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

        ";G",
        "<Cmd>FzfLua git_commits<CR>",
      },
      {
        "gh",
        "<Cmd>:lua require('fzf-lua').lsp_references({ includeDeclaration = false, ignore_current_line = true })<CR>",
      },
      {
        "gd",
        "<Cmd>FzfLua lsp_definitions<CR>",
      },
      {
        ";;",
        "<Cmd>FzfLua resume<CR>",
      },
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
        ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "dashboard", "yazi" },

        -- `ignore_terminal` configures whether to ignore terminal buffers
        ignore_terminal = true,

        -- `return_cursor` configures if cursor should return to previous
        -- position after trimming whitespace
        return_cursor = true,
      })
    end,
  },
  {
    ---@type LazySpec
    {
      "mikavilpas/yazi.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      keys = {
        -- 👇 in this section, choose your own keymappings!
        {
          "<leader>-",
          function()
            require("yazi").yazi()
          end,
          desc = "Open the file manager",
        },
        {
          -- Open in the current working directory
          "<leader>cw",
          function()
            require("yazi").yazi(nil, vim.fn.getcwd())
          end,
          desc = "Open the file manager in nvim's working directory",
        },
      },
      ---@type YaziConfig
      opts = {
        open_for_directories = false,
      },
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
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ff", false },
      { "<leader>fF", false },
      { "<leader><leader>", false },
      -- add a keymap to browse plugin files
    },
  },
}
