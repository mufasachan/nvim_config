-- Basically, the quickstart setup provided by the repo.
-- cmp sources has been added in cmp.lua module.
return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			}
		}
	},
	{ "Bilal2453/luvit-meta", lazy = true },
}
