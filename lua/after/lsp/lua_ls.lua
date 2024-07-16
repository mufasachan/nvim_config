local lua_ls = require("lspconfig").lua_ls

-- This is old, I don't know why it is there.
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local function lsp_knows_vimlua(client)
	local path = client.workspace_folders[1].name
	if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
		return
	end
	client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
		runtime = { version = "LuaJIT" },
		-- Make the server aware of Neovim runtime files
		workspace = {
			checkThirdParty = false,
			library = { vim.env.VIMRUNTIME }
		}
	})
end

local settings = {
	Lua = {
		runtime = {
			version = "LuaJIT",
			path = runtime_path
		},
		diagnostics = { globals = { "vim" } },
		format = { defaultConfig = { quote_style = "double" } },
		workspace = {
			checkThirdParty = false
		},
		telemetry = { enable = false },
	}
}

lua_ls.setup({
	on_init = lsp_knows_vimlua,
	settings = settings
})
