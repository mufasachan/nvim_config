local plugin = {'nvim-treesitter/nvim-treesitter-context'}

plugin.dependencies = {'treesitter'}

function plugin.config()
	local context = require'treesitter-context'
	vim.keymap.set('n', 'gc', context.go_to_context, { expr = true})
end

return plugin

