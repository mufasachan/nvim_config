local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Function to transform text for LaTeX labels: convert letters to lowercase, non-letters to underscores
-- This replicates the VS Code transformation: ${1/([a-zA-Z]+)|([^a-zA-Z]+)/${1:/downcase}${2:+_}/g}
local function transform_label(args)
  local text = args[1][1] or ""
  -- Replace each character: letters become lowercase, non-letters become underscores
  local result = text:gsub(".", function(char)
    if char:match("[a-zA-Z]") then
      return char:lower()
    else
      return "_"
    end
  end)
  return result
end

local snippets = {
  s("sssub", {
    t("\\subsubsection{"), i(1), t("}\\label{ssub:"),
    f(transform_label, { 1 }),                   -- Apply transformation to node 1
    t("} % (fold)"),
    t({ "", "" }),                               -- New line
    i(0),                                        -- Final cursor position with selected text as default
    t({ "", "% subsubsection " }),
    f(function(args) return args[1] end, { 1 }), -- Repeat the subsection title
    t(" (end)")
  }),
  s("para", {
    t("\\paragraph{"),
    i(1, "text"),
    t("}"),
    i(0)
  }),
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
