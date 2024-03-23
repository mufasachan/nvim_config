-- Set hidden files but not .git in vimgrep
-- local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }
-- table.insert(vimgrep_arguments, "--hidden")
-- table.insert(vimgrep_arguments, "--glob")
-- table.insert(vimgrep_arguments, "!**/.git/*")
-- plugin.opts.defaults.vimgrep_arguments = vimgrep_arguments
local plugin = { 'nvim-telescope/telescope.nvim' }
plugin.name = 'telescope'

plugin.keys = {
	{ 'gf',         ':Telescope find_files<CR>',                desc = 'Find files' },
	{ '<leader>?',  ':Telescope oldfiles<CR>',                  desc = 'Recent files' },
	{ '<leader>fg', ':Telescope live_grep<CR>',                 desc = 'Live GREP' },
	{ '<leader>fh', ':Telescope help_tags<CR>',                 desc = 'Help tags' },
	{ '<leader>ft', ':Telescope pickers<CR>',                   desc = 'Pickers' },
	{ 'gs',         ':Telescope lsp_document_symbols<CR>',      desc = 'Document symbols' },
	{ 'gS',         ':Telescope lsp_workspace_symbols<CR>',     desc = 'Workspace symbols' },
	{ '<leader>ff', ':Telescope current_buffer_fuzzy_find<CR>', desc = 'Fuzzy find' },
	{ '<leader>lr', ':Telescope lsp_references<CR>', desc = 'Fuzzy find' },
	-- For diagnositcs, see trouble
	{ 'gr',         ':Telescope lsp_references<CR>' },
	{ 'gt',         ':Telescope lsp_type_definitions<CR>' },
	{ 'gd',         ':Telescope lsp_definitions<CR>' },
}

plugin.dependencies = {
	'nvim-lua/plenary.nvim',
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
}


plugin.opts = {
	defaults = {
		layout_strategy = 'vertical',
		layout_config = {
			width = 0.95,
			height = 0.95,
			preview_height = .55,
			preview_cutoff = 0,
		},
		mappings = {
			n = { ["q"] = "close" },
			i = { ["kj"] = "close" },
		},
	},
	pickers = {
		find_files = {
			find_command = { "fdfind", "-H", "-I", "--exclude", ".git", "--type", "f" },
		}
	},
}

function plugin.config()
	local telescope = require "telescope"

	telescope.load_extension('fzf')
	telescope.setup(plugin.opts)
end

return plugin
