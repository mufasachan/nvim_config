require('user.settings')
require('user.autocommands')
require('user.keymappings')
require('user.plugins')
require('user.neovide')

pcall(vim.cmd.colorscheme, 'pink-moon')
