local map = vim.keymap.set

map('n', '<Leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = 'Next'})
map('n', '<Leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = 'Previous'})

return {
	-- Panel
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		init = function ()
			map('n', '<Leader>dw', ':TroubleToggle<CR>', { desc = 'Workspace'})
			map('n', '<Leader>dd', ':TroubleToggle document_diagnostics<CR>', { desc = 'Document'})
		end
	},
}
