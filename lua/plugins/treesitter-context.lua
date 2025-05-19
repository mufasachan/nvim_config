local M = { "nvim-treesitter/nvim-treesitter-context" }
M.name = "treesitter-context"

M.opts = { max_lines = 4 }
M.dependencies = { "which-key" }

function M.config(_, opts)
  local wk = require "which-key"
  wk.add {
    { "gc", function() require("treesitter-context").go_to_context() end, silent = true },
  }
  require "treesitter-context".setup(opts)
end

return M
