local dir_path = vim.fn.stdpath('config') .. '/lua/after/lsp/'
local files = vim.fn.readdir(dir_path)

--- @type { [string]: boolean} mark LSPs with custom configurations
local is_custom = {}
for _, file in ipairs(files) do
	local lsp_name = string.sub(file, 1, -5)

	-- Exclude current file file
	if file ~= vim.fn.expand("%:t:r") then
		is_custom[lsp_name] = true
	end
end

local mason_lspconfig = require("mason-lspconfig")
--- @type string[]
local lsps_installed = mason_lspconfig.get_installed_servers()
local lspconfig = require"lspconfig"
for i = 1, #lsps_installed do
	local lsp = lsps_installed[i]

	if not is_custom[lsp] then
		lspconfig[lsp].setup({})
	end
end
