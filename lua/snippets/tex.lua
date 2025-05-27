local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local snippets = {
  s("dcsp", {
    t("CUHK-SYSU-PEDES"),
    i(0)
  }),
  s("dcs", {
    t("CUHK-SYSU"),
    i(0)
  }),
  s("dcp", {
    t("CUHK-PEDES"),
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

local wk = require "which-key"
wk.add({
  { lhs = "<Leader>v",  group = "VimTex",                 buffer = 0 },
  { lhs = "<Leader>vc", rhs = "<CMD>VimtexCompile<CR>",   buffer = 0,                 desc = "Toggle compile" },
  { lhs = "<Leader>vt", rhs = "<CMD>VimtexTocToggle<CR>", buffer = 0,                 desc = "Table des matières" },
  { lhs = "<Leader>vv", rhs = "<CMD>VimtexView<CR>",      buffer = 0,                 desc = "Voir PDF" },
  { mode = "i",         lhs = "<C-Enter>",                rhs = "\\\\<Enter><Enter>", buffer = 0 },
})

return snippets, autosnippets
