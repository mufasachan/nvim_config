-- with alacritty bloodmoon theme
local function set_theme()
	vim.cmd.colorscheme("carbonfox")
	vim.o.fillchars = "eob: "
end

local rose_pine_opts = {
	variante = "moon",
	highlight_groups = {
		DashboardHeader = { fg = "gold" },
		DashboardIcon = { fg = "rose" },
		DashboardDesc = { fg = "rose" },
		DashboardKey = { fg = "iris" },
	},
}


return {
	{ "EdenEast/nightfox.nvim", priority = 1000, opts = { options = { transparent = true } } },
	{ "rose-pine/neovim",       priority = 1000, name = "rose-pine",                         opts = rose_pine_opts },
	{ "rebelot/kanagawa.nvim",  priority = 1000 },
	{ "folke/tokyonight.nvim",  priority = 1000, config = set_theme },
}
