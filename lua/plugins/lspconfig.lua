local plugin = { "neovim/nvim-lspconfig" }
plugin.name = "lspconfig"

plugin.event = { "BufReadPre", "BufNewFile" }

return plugin
