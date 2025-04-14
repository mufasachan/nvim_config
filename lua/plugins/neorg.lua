local M = { "nvim-neorg/neorg" }

M.version = "*"
M.build = ":Neorg sync-parsers"
M.dependencies = { "treesitter", "plenary", "nvim-neorg/neorg-telescope", "image" }
local opts = {
	load = {
		["core.defaults"] = {},
		["core.concealer"] = {},
		["core.highlights"] = {},
		["core.latex.renderer"] = {
			config = {
				conceal = true,
				render_on_enter = true,
			}
		},
		["core.dirman"] = {
			config = {
				workspaces = {
					main = "~/documents/neorg",
				},
				default_workspace = "main"
			}
		},
		-- ["core.completion"] = {
		-- 	config = {
		-- 		engine = "nvim-cmp",
		-- 	}
		-- },
		-- ["core.integrations.nvim-cmp"] = {},
		["core.integrations.telescope"] = {},
		["core.integrations.image"] = {},
	}
}

function M.config()
	vim.cmd(":TSEnable highlight")

	require "neorg".setup(opts)
end

return M
