local plugin = {'nvim-treesitter/nvim-treesitter'}
plugin.name = 'treesitter'

plugin.build = {
  build = ":TSUpdate",
}

-- See :help nvim-treesitter-modules
local opts = {
  highlight = {
    enable = true,
  },
  -- :help nvim-treesitter-textobjects-modules
	ensure_installed = {
		"bash",
		"json",
		"python",
		"yaml",
    'lua',
  },
}

function plugin.config()
  local configs = require('nvim-treesitter.configs')
	configs.setup(opts)
end

return plugin
