local plugin = {'nvim-lualine/lualine.nvim'}

plugin.dependencies = {'nvim-tree/nvim-web-devicons'}

-- SPECIFICS COMPONENTS SETTINGS
-- path = 1 is relative path
local filename = {
	'filename',
	path = 1,
}
plugin.opts = {
	options = {
		theme = 'palenight',
		disabled_filetypes = {'NvimTree'}
	},
	sections = {
    lualine_c = {filename},
		lualine_x = {'os.date("%H:%M %p")', 'filetype'},
	},
}

return plugin
