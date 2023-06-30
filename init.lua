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

-- Général
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.sw = 2
vim.opt.ts = 2

local map = vim.api.nvim_set_keymap
-- Exit and save
map("n", "<Leader>wq", ":wq<CR>", {})
map("n", "<Leader>qq", ":q<CR>", {desc = 'Quit'})
map("n", "<Leader>qa", ":qa<CR>", {desc = 'Quit all'})
map("n", "<Leader>qQ", ":q!<CR>", {desc = 'Quit: Force'})
map("n", "<Leader>qA", ":qa!<CR>", {desc = 'Quit all: Force'})
map("n", "<C-s>", ":w<CR>", {})

require("lazy").setup("plugins")
