local M = { "danymat/neogen" }
M.name = "neogen"

M.opts = { snippet_engine = "luasnip" }
function M.config(plugin, opts)
  require(plugin.name).setup(opts)
  require("which-key").add {
    { "grl", "<CMD>Neogen<CR>", silent = true, desc = "Generate docstring" },
  }
end

return M
