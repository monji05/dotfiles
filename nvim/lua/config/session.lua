local dir = vim.fn.stdpath("state") .. "/sessions/"
vim.fn.mkdir(dir, "p")

local started_with_args = vim.fn.argc() > 0

local function session_file()
	return dir .. vim.fn.getcwd():gsub("[/:]", "%%") .. ".vim"
end

vim.api.nvim_create_autocmd("VimLeavePre", {
	group = vim.api.nvim_create_augroup("session-save", { clear = true }),
	callback = function()
		if started_with_args then
			return
		end
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.bo[buf].buflisted and vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= "" then
				vim.cmd("mksession! " .. vim.fn.fnameescape(session_file()))
				return
			end
		end
	end,
})

vim.keymap.set("n", ";s", function()
  local files = vim.fn.glob(dir .. "*.vim", false, true)
  table.sort(files, function(a, b)
    return vim.fn.getftime(a) > vim.fn.getftime(b)
  end)
  if files[1] then
    vim.cmd("silent! source " .. vim.fn.fnameescape(files[1]))
  end
end, { desc = "Restore last session" })
