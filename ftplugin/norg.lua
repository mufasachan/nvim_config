vim.wo.conceallevel = 3
local wk = require("which-key")
wk.add({
	{ lhs = "<leader>N",  group = "Neorg",                        buffer = true },
	{ lhs = "<leader>Nn", rhs = "<Plug>(neorg.dirman.new-note)", desc = "New note" },
	{ lhs = "<leader>Nf", rhs = "<Plug>(neorg.telescope.find_norg_files)", desc = "Find files" },
	{ lhs = "<C-l>", rhs = "<CMD>Telescope neorg insert_file_link<CR>", mode = "i", desc = "Insert link" },
})
