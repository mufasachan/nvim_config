local plugin = { 'nvim-treesitter/nvim-treesitter-textobjects' }
plugin.dependencies = { 'treesitter' }

function plugin.config()
	require("nvim-treesitter.configs").setup {
		textobjects = {
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]c"] = "@conditional.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]C"] = "@conditional.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[c"] = "@conditional.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[C"] = "@conditional.outer",
				},
			},
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					['ac'] = '@conditional.outer',
					['ic'] = '@conditional.inner',
					['af'] = '@function.outer',
					['if'] = '@function.inner',
				}
			},
		},
	}
end

if false then
	print("here")
end

return plugin
