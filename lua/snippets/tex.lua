local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local snippets = {
  s("para", {
    t("\\paragraph{"),
    i(1, "text"),
    t("}"),
    i(0)
  }),
  s("mono", {
    t("\\texttt{"),
    i(1, "text"),
    t("}"),
    i(0)
  }),
}

local autosnippets = {
  s("/p", {
    t("\\parencite{"),
    i(1, "citekey"),
    t("}"),
    i(0)
  }),
  s("/c", {
    t("\\cite{"),
    i(1, "citekey"),
    t("}"),
    i(0)
  }),
  s("/i", {
    t("\\textit{"),
    i(1),
    t("}"),
    i(0)
  }),
  s("/b", {
    t("\\textbf{"),
    i(1, "abbrv"),
    t("}"),
    i(0)
  }),
  s("/-", {
    t("\\item "),
  }),
  s("/g", {
    t("\\gls{"),
    i(1, "abbrv"),
    t("}"),
    i(0)
  }),
}

return snippets, autosnippets
