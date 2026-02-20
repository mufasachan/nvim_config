local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node
local f = ls.function_node

local snippets = {
  s("cell", {
    t({ "```python", "" }),
    i(1),
    t({ "", "```" }),
    i(0),
  })
}

local autosnippets = {}

return snippets, autosnippets
