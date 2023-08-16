-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set({'n', 'x', 'o'}, '<M-h>', '^', { desc = 'Start of line'})
vim.keymap.set({'n', 'x', 'o'}, '<M-l>', 'g_', { desc = 'End of line'})
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>', { desc = 'Select all'})

-- Basic clipboard interaction
-- disable on tablet
-- vim.keymap.set({'n', 'x'}, 'gy', '"+y') -- copy
-- vim.keymap.set({'n', 'x'}, 'gp', '"+p') -- paste

-- Delete text
vim.keymap.set({'n', 'x'}, 'x', '"_x')

-- Exit insert mode
vim.keymap.set("i", "jk", '<esc>')

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", {remap = true})
vim.keymap.set("n", "<C-j>", "<C-w>j", {remap = true})
vim.keymap.set("n", "<C-k>", "<C-w>k", {remap = true})
vim.keymap.set("n", "<C-l>", "<C-w>l", {remap = true})

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { silent = true })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { silent = true })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { silent = true })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { silent = true })

-- Commands
vim.keymap.set("n", "<Leader>q", ":q<CR>", {desc = 'Quit'})
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Save'})
-- Commands: Buffer
vim.keymap.set("n", "<Leader>c", "<cmd>bp|bd#<cr>", { desc = 'Close buffer'})
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Back", silent = true })
-- Commands: Help page
vim.keymap.set("x", "H", '"xy:help <C-R>x<CR>',
	{ desc = "Back", silent = true, noremap = true})

