local ltex = require("lspconfig").ltex

ltex.setup {
	filetypes = { "tex" },
	on_attach = function() require("ltex_extra").setup { load_langs = { "fr" } } end,
	settings = {
		ltex = {
			language = "fr",
		}
	}
}
