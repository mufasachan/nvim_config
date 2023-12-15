local plugin = {'nvim-treesitter/nvim-treesitter-textobjects'}
plugin.dependencies = { 'treesitter' }

local opts = {
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
}
function plugin.config()
	require("nvim-treesitter.configs").setup{opts}
end

return plugin
