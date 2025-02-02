vim.wo.conceallevel = 3

-- Global shortcut
local wk = require("which-key")
wk.add({
	{ lhs = "<leader>N",   group = "Neorg",                                   buffer = true },
	{ lhs = "<leader>Nn",  rhs = "<Plug>(neorg.dirman.new-note)",             desc = "New note" },
	{ lhs = "<leader>Ns",  group = "Search",                                  buffer = true },
	{ lhs = "<leader>Nc",  rhs = "<CMD>Neorg toggle-concealer<CR>",           desc = "Toggle concealer" },
	{ lhs = "<leader>Nsf", rhs = "<Plug>(neorg.telescope.find_norg_files)",   desc = "Find files" },
	{ lhs = "<leader>Nsh", rhs = "<Plug>(neorg.telescope.search_headings)",   desc = "Search headings" },
	{ lhs = "<C-l>",       rhs = "<CMD>Telescope neorg insert_file_link<CR>", mode = "i",               desc = "Insert link" },
})


-- Keyboard shortcut with snippet for insert mode.
local ls = require("luasnip")
local snippet = ls.snippet
local text = ls.text_node
local insert = ls.insert_node

local bold_snippet = snippet("bold", {
	text("*"),
	insert(1),
	text("*"),
})

local url_snippet = snippet("url", {
	text("["),
	insert(1, "title"),
	text("]{"),
	insert(2, "url"),
	text("}"),
	insert(0)
})

ls.add_snippets("norg", { bold_snippet, url_snippet })

vim.keymap.set("i", "<C-k>", function()
	ls.snip_expand(url_snippet)
end, { buffer = true })
vim.keymap.set("i", "<C-b>", function()
	ls.snip_expand(bold_snippet)
end, { buffer = true })
