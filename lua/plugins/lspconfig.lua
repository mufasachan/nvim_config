local plugin = { "neovim/nvim-lspconfig" }
plugin.name = "lspconfig"

plugin.dependencies = {
	"hrsh7th/cmp-nvim-lsp",
	{ "williamboman/mason-lspconfig.nvim", lazy = true, dependencies = "mason" },
	{ "williamboman/mason.nvim", name = "mason", opts = { ui = { border = "rounded" } },
	},
}

plugin.cmd = "LspInfo"
plugin.event = { "BufReadPre", "BufNewFile" }

function plugin.init()
	-- Prettier helps
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
		vim.lsp.handlers.hover,
		{ border = "rounded" }
	)
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
		vim.lsp.handlers.signature_help,
		{ border = "rounded" }
	)
end

local function lsp_keymaps()
	require "which-key".add({ { "<Leader>l", buffer = 0, group = "LSP" }, })
	local bufmap = function(mode, lhs, rhs, desc)
		local opts = { buffer = true, desc = desc }
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
	bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
	bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
	bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
	bufmap("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
	bufmap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename")
	bufmap({ "n", "x" }, "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format")
	bufmap({ "n", "x" }, "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Action")
	bufmap("n", "<leader>li", "<cmd>LspInfo<cr>", "Info")
end

function plugin.config()
	local lspconfig = require "lspconfig"
	local lsp_defaults = lspconfig.util.default_config

	-- Set cmp capabilities to LSP default configs
	lsp_defaults.capabilities = vim.tbl_deep_extend(
		"force",
		lsp_defaults.capabilities,
		require "cmp_nvim_lsp".default_capabilities()
	)

	-- Set generic LSP mappings
	local group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })
	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		desc = "LSP keymaps",
		callback = lsp_keymaps
	})
end

return plugin
