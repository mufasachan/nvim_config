vim.o.conceallevel = 2

local ls = require("luasnip")
local snippets_tex = ls.get_snippets("tex", { type = "snippets" })

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
local names = { "textit" }
--- @type table<string, function>
local name_to_expand_func = {}
for _, name in ipairs(names) do
	name_to_expand_func[name] = function()
		ls.snip_expand(get_snippet_from_name(name), {})
	end
end

local wk = require "which-key"
wk.add({
	{ lhs = "<Leader>v",  group = "VimTex",                 buffer = 0 },
	{ lhs = "<Leader>vc", rhs = "<CMD>VimtexCompile<CR>",   buffer = 0 },
	{ lhs = "<Leader>vt", rhs = "<CMD>VimtexTocToggle<CR>", buffer = 0 },
	{
		mode = "i",
		lhs = "/i",
		rhs = name_to_expand_func["textit"],
		buffer = 0
	}
})

vim.call("vimtex#imaps#add_map", {
	lhs = "-",
	rhs = "\\item ",
	wrapper = "vimtex#imaps#wrap_trivial",
	leader = "/"
})
