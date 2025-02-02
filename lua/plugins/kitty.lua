local plugin = { "mikesmithgh/kitty-scrollback.nvim" }

plugin.enabled = true
plugin.lazy = true
plugin.cmd = {
	"KittyScrollbackGenerateKittens",
	"KittyScrollbackCheckHealth",
	"KittyScrollbackGenerateCommandLineEditing",
}
plugin.config = function()
	require("kitty-scrollback").setup()
end

return plugin
