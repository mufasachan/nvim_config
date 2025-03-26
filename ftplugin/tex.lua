vim.o.conceallevel = 2

-- Keyboard shortcut with snippet for insert mode.
local ls = require("luasnip")
local snippet = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local snippets_tex = ls.get_snippets("tex", { type = "snippets" })


local csu_snippet = snippet("dataset_dt", {
	text("CUHK-SYSU-PEDES"),
	insert(0)
})
table.insert(snippets_tex, csu_snippet)
local pedes_snippet = snippet("dataset_d", {
	text("CUHK-SYSU"),
	insert(0)
})
table.insert(snippets_tex, pedes_snippet)
local sysu_snippet = snippet("dataset_t", {
	text("CUHK-PEDES"),
	insert(0)
})
table.insert(snippets_tex, sysu_snippet)
local parencite_snippet = snippet("parencite", {
	text("\\parencite{"),
	insert(1, "citekey"),
	text("}"),
	insert(0)
})
table.insert(snippets_tex, parencite_snippet)
local cite_snippet = snippet("cite", {
	text("\\cite{"),
	insert(1, "citekey"),
	text("}"),
	insert(0)
})
table.insert(snippets_tex, cite_snippet)
local mono_snippet = snippet("mono", {
	text("\\texttt{"),
	insert(1, "text"),
	text("}"),
	insert(0)
})
table.insert(snippets_tex, mono_snippet)
local gls_snippet = snippet("gls", {
	text("\\gls{"),
	insert(1, "abbrv"),
	text("}"),
	insert(0)
})
table.insert(snippets_tex, gls_snippet)

--- Get a luasnip for each name
---@param name string
---@return any snippet_luasnip
local function get_snippet_from_name(name)
	for _, snippet in ipairs(snippets_tex) do
		if snippet.name == name then
			return snippet
		end
	end
end

--- @type string[]
local names = { "textbf", "textit", "cite", "parencite", "gls", "dataset_d", "dataset_t", "dataset_dt", "mono"}
--- @type table<string, function>
local name_to_expand_func = {}
for _, name in ipairs(names) do
	name_to_expand_func[name] = function()
		ls.snip_expand(get_snippet_from_name(name), {})
	end
end

local function create_insert_wk_table(lhs, name)
	return { mode = "i", lhs = lhs, rhs = name_to_expand_func[name], buffer = 0 }
end

local wk = require "which-key"
wk.add({
	{ lhs = "<Leader>v",  group = "VimTex",                 buffer = 0 },
	{ lhs = "<Leader>vc", rhs = "<CMD>VimtexCompile<CR>",   buffer = 0, desc = "Toggle compile" },
	{ lhs = "<Leader>vt", rhs = "<CMD>VimtexTocToggle<CR>", buffer = 0, desc = "Table des matières"},
	{ lhs = "<Leader>vv", rhs = "<CMD>VimtexView<CR>", buffer = 0, desc = "Voir PDF"},
	{ mode = "i",         lhs = "/-",                       rhs = "\\item ",            buffer = 0 },
	{ mode = "i",         lhs = "<C-Enter>",                rhs = "\\\\<Enter><Enter>", buffer = 0 },
	create_insert_wk_table("/i", "textit"),
	create_insert_wk_table("/b", "textbf"),
	create_insert_wk_table("/c", "cite"),
	create_insert_wk_table("/(", "parencite"),
	create_insert_wk_table("/ ", "gls"),
	create_insert_wk_table("/t", "mono"),
	create_insert_wk_table("/dd", "dataset_d"),
	create_insert_wk_table("/dt", "dataset_t"),
	create_insert_wk_table("/dc", "dataset_dt"),
})

