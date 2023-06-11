return {
  "lewis6991/gitsigns.nvim",
  event = { "BufRead" },
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "|", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "-", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        untracked = { hl = "GitSignsAdd", text = "┆", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      },
      signcolumn = true,
      numhl = false,  -- diff highlight line number
      linehl = false, -- diff highlight line
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        map("n", "<Space>d", ":Gitsigns diffthis<CR>")
        map("n", "<Space>gh", gs.preview_hunk)
        map("n", "<Space>b", ":Gitsigns blame_line<CR>")
      end,
    })
  end,
}
