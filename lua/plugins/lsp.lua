local map = vim.keymap.set

map('n', 'K', ':lua vim.lsp.buf.hover()<CR>')

local M_mason = {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  keys = {{ "<leader>M", "<cmd>Mason<cr>", desc = "Mason"}},
  opts = {},
}

local M_mason_lspconfig = {
  "williamboman/mason-lspconfig.nvim",
  -- Plug LSPs installed by mason 
	config = function(opts)
		require("mason-lspconfig").setup_handlers {
			function (server_name)
				require("lspconfig")[server_name].setup {}
			end
		}
		require("mason-lspconfig").setup(opts)
	end,
	dependencies = M_mason
}

local M = {
	{
		"neovim/nvim-lspconfig",
		-- See cmp-lsp for setup or mason-lspconfig handlers
		dependencies = M_mason_lspconfig,
	},
}

return M
