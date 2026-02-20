require("which-key").add({
  { mode = "n", lhs = "\\i", rhs = "<CMD>MoltenInit<CR>",             desc = "Init molten" },
  { mode = "n", lhs = "\\e", rhs = "<CMD>MoltenEvaluateOperator<CR>", desc = "Evaluate" },
  { mode = "v", lhs = "\\e", rhs = "<CMD>MoltenEvaluateVisual<CR>",   desc = "Visual" },
})
