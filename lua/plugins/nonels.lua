local M = { "nvimtools/none-ls.nvim" }

M.dependencies = {
  "plenary",
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "plenary", "treesitter" },
    opts = {}
  }
}

function M.config()
  local null_ls = require("null-ls")
  null_ls.setup {
    sources = { null_ls.builtins.code_actions.refactoring }
  }
end

return M
