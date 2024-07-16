local plugin = { "https://github.com/RRethy/vim-illuminate" }
plugin.name = "illuminate"

plugin.opts = {
	filetypes_denylist = { "help", "TelescopePrompt", "FineCmdlinePrompt" }
}

plugin.config = function(_, opts)
	require("illuminate").configure(opts)
end

return plugin
