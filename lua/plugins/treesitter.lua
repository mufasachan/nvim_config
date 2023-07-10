local plugin = {'nvim-treesitter/nvim-treesitter'}
plugin.name = 'treesitter'

plugin.dependencies = {
  {'nvim-treesitter/nvim-treesitter-textobjects'}
}

plugin.build = {
  build = ":TSUpdate",
}

-- See :help nvim-treesitter-modules
plugin.opts = {
  highlight = {
    enable = true,
  },
  -- :help nvim-treesitter-textobjects-modules
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
    },
  },
	ensure_installed = {
		"bash",
		"json",
		"python",
		"yaml",
    'lua',
  },
}

function plugin.config(name, opts)
  require('nvim-treesitter.configs').setup(opts)
end

return plugin
