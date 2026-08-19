-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 150 })
	end,
})

-- Return to last edit position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Open file at the last edit position",
	group = vim.api.nvim_create_augroup("restore-cursor-position", { clear = true }),
	callback = function(ev)
		local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(ev.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})
