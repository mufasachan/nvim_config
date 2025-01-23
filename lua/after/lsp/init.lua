-- Note: not sure about the speed of the command
--- @type string lua scripts with custom config 
local files = vim.system({ "find", "lua/after/lsp", "-type", "f", "!", "-name", "init.lua", "-printf", "%f\n"}):wait().stdout
assert(files ~= nil)

--- @type { [string]: boolean} mark LSPs with custom configurations
local is_custom = {}
for file in files:gmatch("([^\n]*)\n?") do
	if file ~= "" then
		is_custom[file] = true
	end
end

local mason_lspconfig = require("mason-lspconfig")
--- @type string[]
local lsps_installed = mason_lspconfig.get_installed_servers()
local lspconfig = require"lspconfig"
for i = 1, #lsps_installed do
	local lsp = lsps_installed[i]

	if is_custom[lsp] == nil then
		lspconfig[lsp].setup({})
	end
end

-- TODO add a loop of all installed lsp and initiate them if they have a matching filenames or not.
-- Custom configurations
require("after.lsp.lua_ls")
require("after.lsp.ltex")
-- require("after.lsp.python")
