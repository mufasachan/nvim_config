-- Might add in the future:
-- m4xshen/hardtime.nvim: Better habits
-- ThePrimeagen/vim-be-good: Game to be better at nvim
-- TODOs:
-- - Set python configuration with tools in the local env (not **Mason**)
-- - Add project feature
-- 		- Proper workspace listing that can be resumed
-- 		- Sort of welcome pane when opening neovim with no argument.

require("user.autocommands")
require("user.ft")
require("user.keymappings")
require("user.neovide")
require("user.plugins")
require("user.settings")

require("lazy").setup("plugins")

require"after"
