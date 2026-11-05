---@diagnostic disable: missing-fields
return {
  {
    "numToStr/Comment.nvim",
    keys = { "<leader>u", "gc" },
    config = function()
      require("Comment").setup({
        toggler = {
          line = "<leader>u",
          block = "gc",
        },
      })
    end,
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", --recommended as each new version will have breaking changes
    opts = {
      bs = { -- *ultimate-autopair-map-backspace-config*
        single_delete = true,
        -- <!--|--> > bs > <!-|
      },
    },
  },
  {
    "nvim-mini/mini.surround",
    -- change html tag command is srtt"
    -- Module mappings. Use `''` (empty string) to disable one.
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding

        suffix_last = "l", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
      },
    },
  },
}
