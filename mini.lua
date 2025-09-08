vim.o.nu, vim.o.rnu = true, true

vim.o.shm = vim.o.shm .. "I"

vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<Leader>w", "<CMD>w<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>n", "<CMD>next<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>p", "<CMD>prev<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>b", "<CMD>b#<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>e", "<CMD>enew<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>q", "<CMD>qa!<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-Left>", "<C-w>h", { silent = true })
vim.api.nvim_set_keymap("n", "<C-Down>", "<C-w>j", { silent = true })
vim.api.nvim_set_keymap("n", "<C-Up>", "<C-w>k", { silent = true })
vim.api.nvim_set_keymap("n", "<C-Right>", "<C-w>l", { silent = true })
