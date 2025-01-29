-- Might add in the future:
-- m4xshen/hardtime.nvim: Better habits
-- ThePrimeagen/vim-be-good: Game to be better at nvim
-- TODOs:
-- - (Major) Set python configuration with tools in the local env (not **Mason**)
--   1. Do it manually for a local repo
--   2. Do it manually for a local repo in a container
--   3. Is scripting/plugin necessary?
-- - (Major) Set DAP, an UI and test it on a real world project
-- - (Medium) TODO and other tags search with Telescope
-- - (Minor) No cursor in dash

require("user.autocommands")
require("user.ft")
require("user.keymappings")
require("user.neovide")
require("user.plugins")
require("user.settings")

require("lazy").setup("plugins", { rocks = { hererocks = true } })

local utils = require("user.utils")
utils.load_modules_in_directory("after/lsp")

-- with alacritty bloodmoon theme
vim.cmd.colorscheme("carbonfox")
vim.o.fillchars = "eob: "
