local lua_ls = require("lspconfig").lua_ls

local settings = {
	Lua = {
		format = { defaultConfig = { quote_style = "double" } },
		workspace = {
			checkThirdParty = false
		},
		telemetry = { enable = false },
	}
}

lua_ls.setup({
	-- on_init = lsp_knows_vimlua,
	settings = settings
})
