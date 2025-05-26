-- Shortcuts
vim.keymap.set({ "n", "x", "o" }, "<M-h>", "^", { desc = "Start of line" })
vim.keymap.set({ "n", "x", "o" }, "<M-l>", "g_", { desc = "End of line" })

-- Clear current line
vim.keymap.set("n", "\\c", "0D", { silent = true })

-- Basic clipboard interaction
-- disable on tablet
-- vim.keymap.set({'n', 'x'}, 'gy', '"+y') -- copy
-- vim.keymap.set({'n', 'x'}, 'gp', '"+p') -- paste

-- Delete text
vim.keymap.set({ "n", "x" }, "x", '"_x')

-- Exit insert mode
vim.keymap.set("i", "jk", "<esc>")

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Splits
vim.keymap.set("n", "<C-z>", "<CMD>vsplit<CR>", { silent = true })
vim.keymap.set("n", "<C-S-z>", "<CMD>split<CR>", { silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { remap = true })
vim.keymap.set("n", "<C-Left>", "<C-w>h", { remap = true })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { remap = true })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { remap = true })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { remap = true })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { silent = true })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { silent = true })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { silent = true })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { silent = true })

-- Commands
vim.keymap.set("n", "<Leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<Leader>Q", ":qa<CR>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
-- Commands: Help page
vim.keymap.set("x", "H", '"xy:help <C-R>x<CR>',
  { desc = "Back", silent = true, noremap = true })

-- Draft
local wk = require "which-key"
wk.add {
  { "<Leader>D", "<CMD>enew<CR>", desc = "Create draft", silent = true }
}
