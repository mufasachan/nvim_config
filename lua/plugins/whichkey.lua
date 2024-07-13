local plugin = { "folke/which-key.nvim" }
plugin.name = "which-key"

-- Version 3.1 was not working, a lot of WK windows appeared, I do not like this.
plugin.dependencies = { "nvim-web-devicons" }
plugin.tag = "v2.0.1"

plugin.init = function ()
       vim.o.timeout = true
  vim.o.timeoutlen = 500

  local wk = require"which-key"
  wk.register({
    ["<Leader>b"] = { name = "Buffer"},
    ["<Leader>f"] = { name = "Finder"},
  })
end

plugin.opts = {
	-- preset = "modern",  To be enabled on version 3
	delay = 200,
	triggers = { "<Leader>", },
	-- icons = { rules = false },  To be enabled on version 3
}


plugin.event = "VeryLazy"

return plugin
