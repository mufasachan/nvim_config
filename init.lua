require('user.settings')
require('user.autocommands')
require('user.keymappings')
require('user.plugins')

pcall(vim.cmd.colorscheme, 'vim-pink-moon')
