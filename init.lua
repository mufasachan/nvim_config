-- Might add in the future:
-- m4xshen/hardtime.nvim: Better habits
-- ThePrimeagen/vim-be-good: Game to be better at nvim
require("user.autocommands")
require("user.ft")
require("user.keymappings")
require("user.neovide")
require("user.plugins")
require("user.settings")

require("lazy").setup("plugins")
