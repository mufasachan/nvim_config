local rose_pine_opts = {
	variante = "moon",
  styles = { transparency = true },
	highlight_groups = {
		DashboardHeader = { fg = "gold" },
		DashboardIcon = { fg = "rose" },
		DashboardDesc = { fg = "rose" },
		DashboardKey = { fg = "iris" },
	},
}

-- test
local opts_nightfox = {
	options = {
		transparent = true,
	},
}

return {
	{ "EdenEast/nightfox.nvim", priority = 1000, opts = opts_nightfox },
	{ "rose-pine/neovim",       priority = 1000, name = "rose-pine",      opts = rose_pine_opts },
	{ "rebelot/kanagawa.nvim",  priority = 1000 },
	{ "folke/tokyonight.nvim",  priority = 1000 },
}
