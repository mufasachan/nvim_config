-- Download lazy if it does not exist already.
-- stdpath("data") is ~/.local/share/nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
-- NOTE: On rajoute dans la recherche de config le répertoire de plugin !
vim.opt.rtp:prepend(lazypath)
-- require -> cherche dans .config/nvim
-- It searches it inside lazy.lua or lazy/init.lua

-- Général
vim.g.mapleader = " "
vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.sw = 2
vim.opt.termguicolors = true

local map = vim.api.nvim_set_keymap
map("n", "<Leader>wq", ":wq<CR>", {})
map("n", "<Leader>q", ":q<CR>", {})
map("n", "<C-s>", ":w<CR>", {})

-- Chargement plugins
require("lazy").setup("plugins")
