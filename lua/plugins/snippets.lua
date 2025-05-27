local M = { "L3MON4D3/LuaSnip" }
M.dependencies = { "rafamadriz/friendly-snippets" }
M.version = "v2.*"
M.build = "make install_jsregexp"
function M.config()
  require("luasnip").setup { enable_autosnippets = true }
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_lua").load {
    paths = { "./lua/snippets" }
  }
end

return M
