local plugin = {"numToStr/Comment.nvim"}
plugin.name = "comment"

plugin.config = function ()
	local api = require('Comment.api')
	local config = require('Comment.config'):get()

	vim.keymap.set('n', '<C-/>', api.toggle.linewise.current)
	vim.keymap.set('n', '<C-?>', api.toggle.blockwise.current)
	-- Toggle (from help file)
	local esc = vim.api.nvim_replace_termcodes(
	'<ESC>', true, false, true
	)
	vim.keymap.set('x', '<C-/>', function()
		vim.api.nvim_feedkeys(esc, 'nx', false)
		api.toggle.linewise(vim.fn.visualmode())
	end)
	vim.keymap.set('x', '<C-?>', function()
		vim.api.nvim_feedkeys(esc, 'nx', false)
		api.toggle.blockwise(vim.fn.visualmode())
	end)

	return config
end

return plugin
