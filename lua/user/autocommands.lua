local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	group = group,
	-- q for Quitting
	-- Focus top window (help window)
	-- resize help page as it was before
	command = 'nnoremap <buffer> q <cmd>quit<cr><C-w>k<cmd>exe "resize " . &helpheight<cr>'
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "man" },
	group = group,
	command = "nnoremap <buffer> q <cmd>quit<cr>"
})
