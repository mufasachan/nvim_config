-- Space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("user.ft")
require("user.neovide")
require("user.plugins")
require("user.options")

require("lazy").setup(
  { spec = "plugins", rocks = { hererocks = true } }
)
vim.cmd.packadd("nohlsearch")

require("user.autocommands")
require("user.keymappings")

-- with alacritty bloodmoon theme
vim.cmd.colorscheme("rose-pine")
vim.o.fillchars = "eob: "
