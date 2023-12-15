local function set_theme()
		vim.cmd("colorscheme catppuccin-macchiato")
end

return {
	{ "sts10/vim-pink-moon", priority = 1000  },
	{ "savq/melange-nvim", priority = 1000 },
	{ "catppuccin/nvim", priority = 1000, config = set_theme }
}
