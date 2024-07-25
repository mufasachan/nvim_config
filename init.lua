-- Might add in the future:
-- m4xshen/hardtime.nvim: Better habits
-- ThePrimeagen/vim-be-good: Game to be better at nvim
-- TODOs:
-- - Set python configuration with tools in the local env (not **Mason**)

require("user.autocommands")
require("user.ft")
require("user.keymappings")
require("user.neovide")
require("user.plugins")
require("user.settings")

require("lazy").setup("plugins")

require"after"
