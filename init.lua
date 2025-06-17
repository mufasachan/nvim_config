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

-- Space as leader key
vim.g.mapleader = " "

require("user.ft")
require("user.neovide")
require("user.plugins")
require("user.options")

require("lazy").setup("plugins")
vim.cmd.packadd("nohlsearch")

require("user.autocommands")
require("user.keymappings")

-- with alacritty bloodmoon theme
-- vim.cmd.colorscheme("carbonfox")
vim.cmd.colorscheme("rose-pine")
vim.o.fillchars = "eob: "
