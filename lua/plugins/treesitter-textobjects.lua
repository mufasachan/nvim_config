local plugin = { 'nvim-treesitter/nvim-treesitter-textobjects' }
plugin.name = "treesitter-textobjects"
plugin.dependencies = { 'treesitter' }

-- See note on Dart in treesitter.lua
plugin.branch = "master"
plugin.commit = "35a60f093fa15a303874975f963428a5cd24e4a0"

function plugin.config()
	require("nvim-treesitter.configs").setup {
		textobjects = {
			move = {
				enable = true,
				disable = { "dart" },
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
