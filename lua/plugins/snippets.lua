local M = { "L3MON4D3/LuaSnip" }
M.dependencies = { "rafamadriz/friendly-snippets" }
M.version = "v2.*"
M.build = "make install_jsregexp"
function M.config()
  local ls = require("luasnip")
  ls.setup { enable_autosnippets = true }
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_lua").load {
    paths = { "./lua/snippets" }
  }


  require("which-key").add {
    { mode = "i",
      lhs = "<M-n>",
      rhs = function() if ls.choice_active() then ls.change_choice(1) end end,
      desc = "Next choice (luasnip)" },
    { mode = "i",
      lhs = "<M-p>",
      rhs = function() if ls.choice_active() then ls.change_choice(-1) end end,
      desc = "Previous choice (luasnip)" },
  }
end

return M
