local map = vim.keymap.set

local function init()
	local builtin = require'telescope.builtin'

	map('n', '<C-p>', builtin.find_files, {desc = "Files"})
	map('n', '<leader>fg', builtin.live_grep, { desc = "grep"})
	map('n', '<leader>fh', builtin.help_tags, { desc = "Help tags"})
	map('n', 'gr', builtin.lsp_references, { desc = "References"})
	map('n', 't', builtin.pickers)
end

local function config()
	local actions = require'telescope.actions'

	require'telescope'.setup{
		defaults = {
      layout_strategy = 'vertical',
			layout_config = {
				width = 0.95,
				height = 0.95,
				preview_height = .6,
				preview_cutoff = 0,
			},
			mappings = {
				n = {
					["<C-c>"] = actions.close,
				},
				i = {
					["<C-o>"] = {"<esc>", type = "command"},
				}
			},
		}
	}
end

return {
	'nvim-telescope/telescope.nvim', tag = '0.1.2',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-treesitter'
	},
	init = init,
	config = config,
}