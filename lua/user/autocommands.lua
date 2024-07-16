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
	desc = [[
		q for Quitting
		Focus top window (help window)
		resize help page as it was before
		NOTE: C-W + C-O set the help page on the window.
	]],
	command = 'nnoremap <buffer> q <CMD>quit<CR><C-W>k<CMD>exe "resize " . &helpheight<CR>'
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	group = group,
	desc = [[
		<CR> Close the qf window
		NOTE: C-W + C-O set the help page on the window.
	]],
	--                                        Close qf    Resize help page to its default size
	command = 'nnoremap <buffer> <CR> <CR><CMD>lclose<CR><CMD>exe "resize " . &helpheight<CR>'
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "man" },
	group = group,
	command = "nnoremap <buffer> q <cmd>quit<cr>"
})
