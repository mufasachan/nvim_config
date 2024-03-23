local plugin = { "folke/which-key.nvim" }
plugin.name = "which-key"

plugin.init = function ()
	vim.o.timeout = true
  vim.o.timeoutlen = 500

  local wk = require"which-key"
  wk.register({
    ["<Leader>l"] = { name = "LSP"},
    ["<Leader>b"] = { name = "Buffer"},
    ["<Leader>f"] = { name = "Finder"},
  })
end

plugin.opts = {
  -- Whichkey is enabled with those keys
  triggers = { "<Leader>", }
}

plugin.event = "VeryLazy"

return plugin
