local plugin = { "nvim-treesitter/nvim-treesitter-context" }

plugin.dependencies = { "treesitter" }

function plugin.config()
	vim.keymap.set("n", "gc", function()
		require("treesitter-context").go_to_context()
	end, { silent = true })
end

return plugin
