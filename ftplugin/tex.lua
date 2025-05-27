vim.o.conceallevel = 2

local wk = require "which-key"
wk.add({
  { lhs = "<Leader>v",  group = "VimTex",                 buffer = 0 },
  { lhs = "<Leader>vc", rhs = "<CMD>VimtexCompile<CR>",   buffer = 0,                 desc = "Toggle compile" },
  { lhs = "<Leader>ve", rhs = "<CMD>VimtexErrors<CR>",    buffer = 0,                 desc = "Check errors" },
  { lhs = "<Leader>vt", rhs = "<CMD>VimtexTocToggle<CR>", buffer = 0,                 desc = "Table des matières" },
  { lhs = "<Leader>vv", rhs = "<CMD>VimtexView<CR>",      buffer = 0,                 desc = "Voir PDF" },
  { mode = "i",         lhs = "<C-Enter>",                rhs = "\\\\<Enter><Enter>", buffer = 0 },
})
