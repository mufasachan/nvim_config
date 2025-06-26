local rose_pine_opts = {
  styles = { transparency = true },
  variante = "moon",
  highlight_groups = {
    DashboardHeader = { fg = "gold" },
    DashboardIcon = { fg = "rose" },
    DashboardDesc = { fg = "rose" },
    DashboardKey = { fg = "iris" },
    DapBreakpoint = { fg = "love" },
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
  { "rose-pine/neovim",       priority = 1000, name = "rose-pine",  opts = rose_pine_opts },
  { "rebelot/kanagawa.nvim",  priority = 1000 },
  { "folke/tokyonight.nvim",  priority = 1000 },
}
