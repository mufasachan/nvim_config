return {
	"sts10/vim-pink-moon",
	{
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
		opts = {
			options = {
				theme = 'palenight',
				disabled_filetypes = { 'NvimTree'}
			},
			sections = {
				lualine_x = {'os.date("%H:%M %p")', 'filetype'},
			},
		},
	}
}
