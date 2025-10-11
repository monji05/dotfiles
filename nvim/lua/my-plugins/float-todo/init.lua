-- ~/.config/nvim/lua/my-plugins/float-todo/init.lua
-- Float TODO: edit your TODO.md directly in a floating window.

local M = {}

-- Default configuration
local default_config = {
  todo_path = vim.fn.stdpath("config") .. "/TODO.md",
  auto_open = true,
  width = 0.6, -- percentage or absolute int
  height = 0.6, -- percentage or absolute int
  border = "rounded",
  zindex = 50,
  reopen_on_write = true, -- refresh/open when TODO.md is written elsewhere
  focus_on_open = true, -- keep focus on float when opening
  autosave_on_close = true, -- save buffer content to file when closing the float
}

M._state = {
  buf = nil,
  win = nil,
  config = vim.deepcopy(default_config),
}

-- Safe file read
local function read_file(path)
  local stat = vim.loop.fs_stat(path)
  if not stat or stat.type ~= "file" then
    return nil, "TODO file not found: " .. path
  end
  local fd = vim.loop.fs_open(path, "r", 438) -- 0666
  if not fd then
    return nil, "Failed to open: " .. path
  end
  local data = vim.loop.fs_read(fd, stat.size, 0)
  vim.loop.fs_close(fd)
  if not data then
    return "", nil
  end
  return data, nil
end

-- Safe file write
local function write_file(path, content)
  local dir = vim.fn.fnamemodify(path, ":h")
  if dir ~= "" then
    vim.fn.mkdir(dir, "p")
  end
  local fd = vim.loop.fs_open(path, "w", 420) -- 0644
  if not fd then
    return false, "Failed to open for writing: " .. path
  end
  local ok = vim.loop.fs_write(fd, content, 0)
  vim.loop.fs_close(fd)
  if not ok then
    return false, "Failed to write: " .. path
  end
  return true, nil
end

-- Resolve dimension (percentage or absolute)
local function resolve_dim(dim, total)
  if type(dim) == "number" then
    if dim > 1 and dim == math.floor(dim) then
      return math.max(1, math.min(dim, total))
    else
      local v = math.floor(total * dim)
      return math.max(1, math.min(v, total))
    end
  end
  return math.floor(total * 0.6)
end

-- Create or reuse buffer
local function ensure_buf()
  if M._state.buf and vim.api.nvim_buf_is_valid(M._state.buf) then
    return M._state.buf
  end
  local buf = vim.api.nvim_create_buf(false, true) -- scratch, nofile
  -- Buffer options
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = "markdown"
  vim.bo[buf].modifiable = true
  -- Optional: set a name so :ls shows something meaningful
  vim.api.nvim_buf_set_name(buf, "[Float TODO]")
  M._state.buf = buf
  return buf
end

-- Render content into buffer (keep modifiable for editing)
local function render_content(buf, content)
  local lines = {}
  for s in string.gmatch(content or "", "([^\r\n]*)\r?\n?") do
    table.insert(lines, s)
  end
  if #lines == 0 then
    lines = { "" }
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

-- Get buffer content
local function get_buf_content(buf)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  return table.concat(lines, "\n")
end

-- Save current float buffer to file
local function save_todo()
  local cfg = M._state.config
  if not (M._state.buf and vim.api.nvim_buf_is_valid(M._state.buf)) then
    vim.notify("[Float TODO] No buffer to save", vim.log.levels.WARN)
    return
  end
  local content = get_buf_content(M._state.buf)
  local ok, err = write_file(cfg.todo_path, content)
  if not ok then
    vim.notify("[Float TODO] " .. err, vim.log.levels.ERROR)
  else
    vim.notify("[Float TODO] Saved to " .. cfg.todo_path, vim.log.levels.INFO)
  end
end

-- Open floating window (editable)
function M.open()
  if M._state.win and vim.api.nvim_win_is_valid(M._state.win) then
    -- already open; just focus it
    vim.api.nvim_set_current_win(M._state.win)
    return
  end

  local cfg = M._state.config
  local prev_win = vim.api.nvim_get_current_win()

  local columns = vim.o.columns
  local lines = vim.o.lines - vim.o.cmdheight

  local width = resolve_dim(cfg.width, columns)
  local height = resolve_dim(cfg.height, lines)
  local row = math.floor((lines - height) / 2)
  local col = math.floor((columns - width) / 2)

  local buf = ensure_buf()

  -- Load file content (or bootstrap text)
  local content, err = read_file(cfg.todo_path)
  if err then
    content = "# TODO\n\n"
      .. "- Start typing your tasks.\n"
      .. '- Press "w" in normal mode to save.\n\n'
      .. "File path: "
      .. cfg.todo_path
  end
  render_content(buf, content)

  -- Open float
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = cfg.border,
    zindex = cfg.zindex,
    noautocmd = false,
  })

  M._state.win = win

  -- Window-local options
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].cursorline = false
  vim.wo[win].signcolumn = "no"
  vim.wo[win].wrap = true
  vim.wo[win].list = false
  vim.wo[win].conceallevel = 2

  -- Ensure buffer is editable
  vim.api.nvim_buf_set_option(buf, "modifiable", true)

  -- Keymaps inside the float:
  vim.keymap.set("n", "q", function()
    if M._state.config.autosave_on_close then
      save_todo()
    end
    M.close()
  end, { buffer = buf, nowait = true, silent = true, desc = "Close float" })

  vim.keymap.set("n", "<Esc>", function()
    if M._state.config.autosave_on_close then
      save_todo()
    end
    M.close()
  end, { buffer = buf, nowait = true, silent = true, desc = "Close float" })

  vim.keymap.set("n", "w", save_todo, { buffer = buf, nowait = true, silent = true, desc = "Save TODO.md" })

  -- Optional: return focus to previous window
  if not cfg.focus_on_open and prev_win and vim.api.nvim_win_is_valid(prev_win) then
    vim.api.nvim_set_current_win(prev_win)
  end
end

function M.close()
  if M._state.win and vim.api.nvim_win_is_valid(M._state.win) then
    vim.api.nvim_win_close(M._state.win, true)
  end
  M._state.win = nil
end

function M.toggle()
  if M._state.win and vim.api.nvim_win_is_valid(M._state.win) then
    M.close()
  else
    M.open()
  end
end

function M.setup(opts)
  M._state.config = vim.tbl_deep_extend("force", vim.deepcopy(default_config), opts or {})

  -- Commands
  vim.api.nvim_create_user_command("TodoFloatOpen", function()
    M.open()
  end, {})
  vim.api.nvim_create_user_command("TodoFloatClose", function()
    if M._state.config.autosave_on_close then
      save_todo()
    end
    M.close()
  end, {})
  vim.api.nvim_create_user_command("TodoFloatToggle", function()
    M.toggle()
  end, {})
  vim.api.nvim_create_user_command("TodoFloatSave", function()
    save_todo()
  end, {})

  -- Autocmds
  local aug = vim.api.nvim_create_augroup("TodoFloatAutocmds", { clear = true })

  -- Refresh after external writes to TODO.md
  if M._state.config.reopen_on_write then
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = aug,
      pattern = M._state.config.todo_path,
      callback = function()
        -- If the float buffer is open, refresh its content
        if M._state.buf and vim.api.nvim_buf_is_valid(M._state.buf) then
          local content, _ = read_file(M._state.config.todo_path)
          if content then
            render_content(M._state.buf, content)
          end
        else
          -- Otherwise open the float
          M.open()
        end
      end,
      desc = "Refresh TODO float after writing file",
    })
  end
end

return M
