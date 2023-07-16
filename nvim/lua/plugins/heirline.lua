local conditions = require("heirline.conditions")
local util = require("plugins.heirline-config.util")
local mode = util.mode
local utils = require("heirline.utils")
local bo = vim.bo
local fn = vim.fn
local api = vim.api
local icons = util.icons
local devicons = require('nvim-web-devicons')
local neo = require("plugins.heirline-config.neosolarized")
local hl = neo.highlight
local colors = neo.colors

local Align, Space, Null, ReadOnly
do
  Space = setmetatable({ provider = ' ' }, {
    __call = function(_, n)
      return { provider = string.rep(' ', n) }
    end
  })
  ReadOnly = {
    condition = function() return not bo.modifiable or bo.readonly end,
    provider = icons.padlock,
  }
end

-- Flexible components priorities
local priority = {
  CurrentPath = 60,
  Git = 40,
  WorkDir = 25,
  Lsp = 10,
}

local Indicator
do
  local VimMode
  do
    local NormalModeIndicator = {
      Space,
      {
        fallthrough = false,
        ReadOnly,
        {
          provider = icons.circle,
          hl = function()
            if bo.modified then
              -- return { fg = hl.Mode.insert.bg }
              return { fg = colors.green }
            else
              return hl.Mode.normal
            end
          end
        }
      },
      Space
    }

    local ActiveModeIndicator = {
      condition = function(self)
        return self.mode ~= 'normal'
      end,
      hl = { bg = hl.StatusLine.bg },
      utils.surround(
        { icons.powerline.left_rounded, icons.powerline.right_rounded },
        function(self) -- color
          return hl.Mode[self.mode].bg
        end,
        {
          {
            fallthrough = false,
            ReadOnly,
            { provider = icons.circle }
          },
          Space,
          {
            provider = function(self)
              return util.mode_label[self.mode]
            end,
          },
          hl = function(self)
            return hl.Mode[self.mode]
          end
        }
      )
    }

    VimMode = {
      init = function(self)
        self.mode = mode[fn.mode(1)] -- :h mode()
      end,
      condition = function() return bo.buftype == '' end,
      {
        fallthrough = false,
        ActiveModeIndicator,
        NormalModeIndicator,
      }
    }
  end

  Indicator = {
    fallthrough = false,
    VimMode
  }
end

local LSPActive = {
  Space,
  condition = conditions.lsp_attached,
  update    = { 'LspAttach', 'LspDetach' },

  -- You can keep it simple,
  -- provider = " [LSP]",

  -- Or complicate things a bit and get the servers names
  provider  = function()
    local names = {}
    for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      table.insert(names, server.name)
    end
    return " " .. table.concat(names, " ")
  end,
  hl        = { fg = "green", bold = true },
  Space
}

local Git = {
  Space,
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = "orange" },


  { -- git branch name
    provider = function(self)
      return " " .. self.status_dict.head
    end,
    hl = { bold = true }
  },
  -- You could handle delimiters, icons and counts similar to Diagnostics
  Space
}

local FileNameBlock = {
  -- let's first set up some attributes needed by this component and it's children
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}
-- We can now define some children separately and add them later

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end
}

local FileName = {
  provider = function(self)
    -- first, trim the pattern relative to the current directory. For other
    -- options, see :h filename-modifers
    local filename = vim.fn.fnamemodify(self.filename, ":.")
    if filename == "" then return "[No Name]" end
    -- now, if the filename would occupy more than 1/4th of the available
    -- space, we trim the file path to its initials
    -- See Flexible Components section below for dynamic truncation
    if not conditions.width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename
  end,
  hl = { fg = utils.get_highlight("Directory").fg },
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = "[+]",
    hl = { fg = "green" },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = "",
    hl = { fg = "orange" },
  },
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

local FileNameModifer = {
  hl = function()
    if vim.bo.modified then
      -- use `force` because we need to override the child's hl foreground
      return { fg = "cyan", bold = true, force = true }
    end
  end,
}

-- not works, why?
-- local FileEncoding = {
--   provider = function()
--     local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
--     return enc ~= 'utf-8' and enc:upper()
--   end
-- }

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(FileNameBlock,
  FileIcon,
  utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
  FileFlags,
  { provider = '%<' }                      -- this means that the statusline is cut here when there's not enough space
)

local LSPMessages = {
  Space,
  provider = require("lsp-status").status,
  hl = { fg = "gray" },
  Space,
}

local DefaultStatusline = {
  -- ViMode, Space, FileNameBlock, Space, Git, Space, Diagnostics, Align,
  -- Navic, DAPMessages, Align,
  -- LSPActive, Space, LSPMessages, Space, UltTest, Space, FileType, Space, Ruler, Space, ScrollBar

  -- ViMode, Git, LSPActive, LSPMessages
  Indicator, Git, LSPActive, FileNameBlock,
}

require("heirline").setup({
  statusline = DefaultStatusline
})
