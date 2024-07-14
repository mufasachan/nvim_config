local plugin = { "tpope/vim-surround" }

plugin.keys = {
	"ds",
	"cs",
	"cS",
	"ys",
	"yS",
	"yss",
	"ySs",
	"ySS",
	{ "S",  mode = "x" },
	{ "gS", mode = "x" },
}

return plugin
