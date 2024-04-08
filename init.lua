-- Might add in the future:
-- m4xshen/hardtime.nvim: Better habits
-- ThePrimeagen/vim-be-good: Game to be better at nvim
-- karb94/neoscroll.nvim: Crazy good looking scrolling
require('user.settings')
require('user.autocommands')
require('user.plugins')
require('user.keymappings')
require('user.ft')

require("lazy").setup("plugins")
