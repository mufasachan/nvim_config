vim.o.nu, vim.o.rnu = true, true

vim.o.shm = vim.o.shm .. "I"

vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<Leader>n", "<CMD>next<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>p", "<CMD>prev<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>b", "<CMD>b#<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>e", "<CMD>enew<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>q", "<CMD>qa!<CR>", { silent = true })
