local plugin = { "folke/which-key.nvim" }
plugin.name = "which-key"

plugin.dependencies = { "nvim-web-devicons" }

plugin.init = function()
	local wk = require "which-key"
	wk.add({
		{ "<Leader>b", group = "Buffer" },
		{ "<Leader>f", group = "Finder" },
	})
end

plugin.opts = {
	preset = "modern",
	delay = 200,
	plugins = {
		marks = false,
		registers = false,
		spelling = { enabled = false },
		presets = {
			operators = false,
			motions = false,
			text_objects = false,
			windows = false,
			nav = false,
			z = false,
			g = false,
		},
	},
	triggers = {
		{ "<Leader>", mode = {"n"}}
	},
	icons = { rules = false },
}

plugin.event = "VeryLazy"

return plugin
