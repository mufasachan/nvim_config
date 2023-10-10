local plugin = {"numToStr/Comment.nvim"}
plugin.name = "comment"

plugin.config = function ()
	local api = require('Comment.api')
	local config = require('Comment.config'):get()

	vim.keymap.set('n', '<C-/>', api.toggle.linewise.current)
	vim.keymap.set('n', '<C-?>', api.toggle.blockwise.current)

	return config
end

plugin.opts = {
toggle={
	line = 'C-/'
	}
}

return plugin
