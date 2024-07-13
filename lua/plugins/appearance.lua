local function set_theme()
	vim.cmd("colorscheme laserwave")
end

return {
	{ "lettertwo/laserwave.nvim",     priority = 1000 },                         -- <3/10
	{ "M1nts02/akane.nvim",           priority = 1000 },                         -- 8 /10
	{ "luisiacc/handmade-hero-theme", priority = 1000 },                         -- 8 /10
	{ "pauchiner/pastelnight.nvim",   priority = 1000 },                         -- 7 /10
	{ "savq/melange-nvim",            priority = 1000 },                         -- 7 /10
	{ "folke/tokyonight.nvim",        priority = 1000, config = set_theme },     -- solid
	{ "catppuccin/nvim",              priority = 1000, name = "hippster_theme" }, -- Do not have MacOS
}
