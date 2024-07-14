local plugin = { "stevearc/dressing.nvim" }

plugin.opts = {
	enabled = true,
	input = {
		mappings = {
			i = {
				["jk"] = "<Esc>"
			},
		},
	},
	select = {
		telescope = {
			layout_strategy = "vertical",
			layout_config = {
				height = .4,
				width = .6,
			},
		},
	},
}

return plugin
