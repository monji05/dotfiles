-- ref: anuvyklack/dotfiles
local conditions = require("heirline.conditions")
local os_sep = package.config:sub(1, 1)
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
local lsp_colors = neo.lsp_colors
local dap = require('dap')

local Align, Space, Null, ReadOnly
do
  Null = { provider = '' }

  Align = { provider = '%=' }

  Space = setmetatable({ provider = ' ' }, {
    __call = function(_, n)
      return { provider = string.rep(' ', n) }
    end
  })
  ReadOnly = {
    condition = function() return not bo.modifiable or bo.readonly end,
    provider = icons.padlock,
    hl = hl.ReadOnly
  }
end

local LeftCap = {
  provider = '▌',
  -- provider = '',
  hl = hl.Mode.normal
}

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
              return { fg = colors.green, bg = colors.base03 }
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

local Lsp
do
  local LspIndicator = {
    provider = icons.circle_small .. ' ',
    hl = hl.LspIndicator
  }

  local LspServer = {
    Space,
    {
      provider = function(self)
        local names = self.lsp_names
        if #names == 1 then
          names = names[1]
        else
          -- names = table.concat(vim.tbl_flatten({ '[', names, ']' }), ' ')
          names = table.concat(names, ', ')
        end
        return names
      end,
    },
    Space(2),
    hl = hl.LspServer
  }

  Lsp = {
    condition = conditions.lsp_attached,
    init = function(self)
      local names = {}
      for _, server in pairs(vim.lsp.buf_get_clients(0)) do
        table.insert(names, server.name)
      end
      self.lsp_names = names
    end,
    hl = function(self)
      local color
      for _, name in ipairs(self.lsp_names) do
        if lsp_colors[name] then
          color = lsp_colors[name]
          break
        end
      end
      if color then
        return { fg = color, bold = true, force = true }
      else
        return hl.LspServer
      end
    end,
    flexible = priority.Lsp,

    LspServer,
    LspIndicator
  }
end

local Git = {
  Space,
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = hl.Git.branch.fg, bold = true },


  { -- git branch name
    provider = function(self)
      return " " .. self.status_dict.head
    end,
    hl = { bold = true }
  },
  -- You could handle delimiters, icons and counts similar to Diagnostics
  Space
}

local FileNameBlock, CurrentPath, FileName
do
  local FileIcon = {
    condition = function()
      return not ReadOnly.condition()
    end,
    init = function(self)
      local filename = self.filename
      local extension = fn.fnamemodify(filename, ':e')
      self.icon, self.icon_color = devicons.get_icon_color(
        filename, extension, { default = true })
    end,
    provider = function(self)
      if self.icon then return self.icon .. ' ' end
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end
  }

  local WorkDir = {
    condition = function(self)
      if bo.buftype == '' then
        return self.pwd
      end
    end,
    hl = hl.WorkDir,
    flexible = priority.WorkDir,
    { provider = function(self) return self.pwd end },
    { provider = function(self) return fn.pathshorten(self.pwd) end },
    Null
  }

  CurrentPath = {
    condition = function(self)
      if bo.buftype == '' then
        return self.current_path
      end
    end,
    hl = hl.CurrentPath,
    flexible = priority.CurrentPath,
    { provider = function(self) return self.current_path end, },
    { provider = function(self) return fn.pathshorten(self.current_path, 2) end, },
    { provider = '' },
  }

  FileName = {
    provider = function(self) return self.filename end,
    hl = hl.FileName
  }

  FileNameBlock = {
    { FileIcon,       WorkDir, CurrentPath, FileName },
    -- This means that the statusline is cut here when there's not enough space.
    { provider = '%<' }
  }
end


local FileProperties = {
  condition = function(self)
    self.filetype = bo.filetype

    local encoding = (bo.fileencoding ~= '' and bo.fileencoding) or vim.o.encoding
    self.encoding = (encoding ~= 'utf-8') and encoding or nil

    local fileformat = bo.fileformat

    -- if fileformat == 'dos' then
    --    fileformat = ' '
    -- elseif fileformat == 'mac' then
    --    fileformat = ' '
    -- else  -- unix'
    --    fileformat = ' '
    --    -- fileformat = nil
    -- end

    if fileformat == 'dos' then
      fileformat = 'CRLF'
    elseif fileformat == 'mac' then
      fileformat = 'CR'
    else -- 'unix'
      -- fileformat = 'LF'
      fileformat = nil
    end

    self.fileformat = fileformat

    return self.fileformat or self.encoding
  end,
  provider = function(self)
    local sep = (self.fileformat and self.encoding) and ' ' or ''
    return table.concat { ' ', self.fileformat or '', sep, self.encoding or '', ' ' }
  end,
  hl = hl.FileProperties,
}

local DapMessages = {
  -- display the dap messages only on the debugged file
  condition = function()
    -- local session = dap_available and dap.session()
    local session = dap.session()
    if session then
      local filename = api.nvim_buf_get_name(0)
      if session.config then
        local progname = session.config.program
        return filename == progname
      end
    end
    return false
  end,
  provider = function()
    return ' ' .. dap.status() .. ' '
  end,
  hl = hl.DapMessages
}

local StatusLines = {
  init = function(self)
    local pwd = fn.getcwd(0) -- Present working directory.
    local current_path = api.nvim_buf_get_name(0)
    local filename

    if current_path == "" then
      pwd = fn.fnamemodify(pwd, ':~')
      current_path = nil
      filename = ' [No Name]'
    elseif current_path:find(pwd, 1, true) then
      filename = fn.fnamemodify(current_path, ':t')
      current_path = fn.fnamemodify(current_path, ':~:.:h')
      pwd = fn.fnamemodify(pwd, ':~') .. os_sep
      if current_path == '.' then
        current_path = nil
      else
        current_path = current_path .. os_sep
      end
    else
      pwd = nil
      filename = fn.fnamemodify(current_path, ':t')
      current_path = fn.fnamemodify(current_path, ':~:.:h') .. os_sep
    end

    self.pwd = pwd
    self.current_path = current_path -- The opened file path relevant to pwd.
    self.filename = filename
  end,
  hl = hl.StatusLine,
  {
    LeftCap, Indicator,
    Space,
    Git, Lsp,
    {
      fallthrough = false,
      { FileNameBlock, }
    },
    Space(4),
    Align,
    DapMessages,
    FileProperties,
  }
}

require("heirline").setup({
  statusline = StatusLines
})
