local M = { "nvim-treesitter/nvim-treesitter-context" }
M.name = "treesitter-context"

M.opts = { max_lines = 4 }

function M.config(plugin, opts)
  local wk = require "which-key"
  local context = require(plugin.name)

  wk.add {
    { "gC", function() context.go_to_context() end, silent = true },
  }

  context.setup(opts)
end

return M
