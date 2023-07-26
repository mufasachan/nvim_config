local user = {}
function user.setup_mason()
  require('mason').setup({
    ui = {border = 'rounded'}
  })

  require('mason-lspconfig').setup({
    ensure_installed = {
			-- 'lua_ls', System install
			'pyright',
			'taplo', -- TOML
    }
  })
end

function user.on_attach()
  local bufmap = function(mode, lhs, rhs, desc)
    local opts = {buffer = true, desc = desc}
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
  bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
  bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
  bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
  bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
  bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
  bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
  bufmap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename')
  bufmap({'n', 'x'}, '<leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', 'Format')
  bufmap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Action')
  bufmap('n', '<leader>li', '<cmd>LspInfo<cr>', 'Info')
end

local plugin = {"neovim/nvim-lspconfig"}
plugin.name = "lspconfig"

plugin.dependencies = {
	"hrsh7th/cmp-nvim-lsp",
	{"williamboman/mason-lspconfig.nvim", lazy = true},
	{
		"williamboman/mason.nvim",
		cmd = { 'Mason', 'LspInstall', 'LspUninstall'},
		keys = { {'<leader>M', '<cmd>Mason<CR>', desc = 'Mason'} },
		config = function () user.setup_mason() end
	},
}

plugin.cmd = 'LspInfo'
plugin.event = {'BufReadPre', 'BufNewFile'}

function plugin.init()
	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = 'rounded'}
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {border = 'rounded'}
  )
end

function plugin.config()
	local lspconfig = require'lspconfig'
	local lsp_defaults = lspconfig.util.default_config

	lsp_defaults.capabilities = vim.tbl_deep_extend(
		'force',
		lsp_defaults.capabilities,
		require'cmp_nvim_lsp'.default_capabilities()
	)

	local group = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})

	vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    desc = 'LSP actions',
    callback = user.on_attach
  })

	require'mason-lspconfig'.setup_handlers({
		function (server)
			lspconfig[server].setup({})
		end,
	})
	require('plugins.lsp.lua_ls')

end

return plugin
