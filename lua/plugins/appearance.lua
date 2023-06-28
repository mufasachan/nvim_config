return {
  {
    "sts10/vim-pink-moon",
    config = function()
      vim.opt.termguicolors = true
      vim.cmd([[colorscheme pink-moon]])
    end,
    priority = 1000,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    opts = {
      options = {
	theme = 'palenight',
	disabled_filetypes = { 'NvimTree'}
      },
      sections = {
	lualine_x = {'os.date("%H:%M %p")', 'filetype'},
      },
    },
  }
}
