local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local snippets = {
  s(
    "mainf",
    {
      t { "def main():", "\t" },
      i(1),
      t { "", "", 'if __name__ == "__main__":', "\tmain()", "" }
    }),
}

local autosnippets = {}

return snippets, autosnippets
