local plugin = { "VonHeikemen/fine-cmdline.nvim" }
plugin.name = "fine-cmdline"

plugin.dependencies = {
	"MunifTanjim/nui.nvim"
}

local opts = {
	hooks = {
		after_mount = function(input)
			vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = input.bufnr })
		end
	}
}
plugin.config = function ()
	require("fine-cmdline").setup(opts)
	vim.keymap.set("n", "<CR>", "<CMD>FineCmdline<CR>")
end

return plugin
