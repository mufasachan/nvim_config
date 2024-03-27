local plugin = { 'nvim-treesitter/nvim-treesitter' }
plugin.name = 'treesitter'

plugin.build = {
	build = ":TSUpdate",
}



-- Error / bad implementation with dart
-- https://github.com/NvChad/NvChad/issues/2237#issuecomment-1653019941
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/5868
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/4945
-- Commit with the best working usage
plugin.branch = "master"
plugin.commit = "f2778bd1a28b74adf5b1aa51aa57da85adfa3d16"

-- See :help nvim-treesitter-modules
local opts = {
	highlight = {
		enable = true,
	},
	-- :help nvim-treesitter-textobjects-modules
	ensure_installed = {
		"bash",
		"json",
		"python",
		"yaml",
		'lua',
	},
	indent = {
		enable = true,
		disable = { "dart" },
	},
}

function plugin.config()
	local configs = require('nvim-treesitter.configs')
	configs.setup(opts)
end

return plugin
