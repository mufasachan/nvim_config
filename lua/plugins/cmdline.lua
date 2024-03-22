local plugin = { "VonHeikemen/fine-cmdline.nvim" }
plugin.name = "fine-cmdline"

plugin.dependencies = {
	"MunifTanjim/nui.nvim"
}

plugin.config = function()
	require("fine-cmdline").setup()

	vim.api.nvim_set_keymap('n', '<CR>', '<cmd>FineCmdline<CR>', { noremap = true })
end

return plugin
