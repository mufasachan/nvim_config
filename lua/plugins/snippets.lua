local M = { "L3MON4D3/LuaSnip" }
M.depencies = { "rafamadriz/friendly-snippets" }
M.version = "v2.*"
M.build = "make install_jsregexp"
function M.config()
  require("luasnip.loaders.from_lua").load {
    paths = { "./lua/snippets" }
  }
end

return M
