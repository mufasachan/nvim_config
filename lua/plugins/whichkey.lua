local function init()
  vim.o.timeout = true
  vim.o.timeoutlen = 500

  local wk = require'which-key'
  wk.register({
    ["<Leader>b"] = { name = "Buffer"},
  })
end

local options = {
  -- Whichkey is enabled with those keys
  triggers = { "<Leader>", }
}

return {{
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = init,
  opts = options,
}}
