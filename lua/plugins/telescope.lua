local plugin = {'nvim-telescope/telescope.nvim'}
plugin.name = 'telescope'

plugin.dependencies = {
	'nvim-lua/plenary.nvim',
	{'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
}

plugin.keys = {
	{'<C-p>', ':Telescope find_files<CR>'},
	{'<leader>?', ':Telescope oldfiles<CR>', desc = 'Recent files'},
	{'<leader>fg', ':Telescope live_grep<CR>', desc = 'Live GREP'},
	{'<leader>fh', ':Telescope help_tags<CR>', desc = 'Help tags'},
	{'<leader>ft', ':Telescope pickers<CR>', desc = 'Pickers'},
	{'<leader>fs', ':Telescope lsp_document_symbols<CR>', desc = 'Document symbols'},
	{'<leader>fS', ':Telescope lsp_workspace_symbols<CR>', desc = 'Workspace symbols'},
	-- For diagnositcs, see trouble
	{'gr', ':Telescope lsp_references<CR>'},
	{'gt', ':Telescope lsp_type_definitions<CR>'},
	{'gd', ':Telescope lsp_definitions<CR>'},
	{'gr', ':Telescope lsp_references<CR>'},
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
			i = { ["jk"] = {"<esc>", type = "command"}, },
		}
	}
}

function plugin.config()
	local opts = plugin.opts
	opts.defaults.mappings.n = { ['q'] = require'telescope.actions'.close}

	require'telescope'.setup(opts)
end

return plugin

