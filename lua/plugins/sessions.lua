local plugin = { "olimorris/persisted.nvim" }
plugin.name = "persisted"

plugin.dependencies = { "telescope" }

plugin.config = function()
	local telescope = require "telescope"
	telescope.load_extension("persisted")

	vim.keymap.set("n", "<Leader>s", "<CMD>Telescope persisted<CR>", { desc = "Sessions", silent = true })

	require "persisted".setup { autoload = true }
end

return plugin
