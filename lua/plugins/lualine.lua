local plugin = { "nvim-lualine/lualine.nvim" }

plugin.dependencies = { "nvim-web-devicons" }

-- SPECIFICS COMPONENTS SETTINGS
-- path = 1 is relative path
plugin.opts = {
	options = {
		globalstatus = true,
		disabled_filetypes = { "NvimTree", "dashboard" }
	},
	sections = {
		lualine_c = { { "filename", path = 1 }, },
		lualine_x = { 'os.date("%H:%M %p")', "filetype" },
	},
}

return plugin
