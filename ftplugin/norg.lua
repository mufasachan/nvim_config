vim.wo.conceallevel = 3

-- Global shortcut
local wk = require("which-key")
wk.add({
	{ lhs = "<leader>N",  group = "Neorg",                        buffer = true },
	{ lhs = "<leader>Nn", rhs = "<Plug>(neorg.dirman.new-note)", desc = "New note" },
	{ lhs = "<leader>Ns",  group = "Search",                        buffer = true },
	{ lhs = "<leader>Nc", rhs = "<CMD>Neorg toggle-concealer<CR>", desc = "Toggle concealer" },
	{ lhs = "<leader>Nsf", rhs = "<Plug>(neorg.telescope.find_norg_files)", desc = "Find files" },
	{ lhs = "<leader>Nsh", rhs = "<Plug>(neorg.telescope.search_headings)", desc = "Search headings" },
	{ lhs = "<C-l>", rhs = "<CMD>Telescope neorg insert_file_link<CR>", mode = "i", desc = "Insert link" },
})


-- Keyboard shortcut with snippet for insert mode.
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local bold_snippet = s("md_bold", {
  t("*"),
  i(1),
  t("* "),
  i(2),
})

ls.add_snippets("markdown", { bold_snippet })

vim.keymap.set("i", "<C-b>", function()
  ls.snip_expand(bold_snippet)
end, { buffer = true })
