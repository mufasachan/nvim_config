local plugin = { "nvim-treesitter/nvim-treesitter" }
plugin.name = "treesitter"

plugin.build = {
	build = ":TSUpdate",
}

-- See :help nvim-treesitter-modules
plugin.opts = {
	ensure_installed = {
		"c",
		"vim",
		"vimdoc",
		"query",
		"markdown",
		"markdown_inline",
		"bash",
		"json",
		"python",
		"yaml",
		"lua"
	},
	highlight = { enable = true },
	incremental_selection = { enable = true },
	textobjects = { enable = true },
	indent = {
		enable = true,
		disable = { "dart" },
	},
}

return plugin
