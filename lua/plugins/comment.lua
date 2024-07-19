local plugin = { "numToStr/Comment.nvim" }
plugin.name  = "comment"

plugin.opts  = {
	toggler = { line = "<C-\\><C-\\>", block = "<C-|><C-|>" },
	opleader = { line = "<C-\\>", block = "<C-|>" },
}

return plugin
