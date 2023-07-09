require('user.settings')
require('user.autocommands')
require('user.keymappings')
require('user.plugins')

pcall(vim.cmd.colorscheme, 'pink-moon')
