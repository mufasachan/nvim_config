local plugin = { "VonHeikemen/fine-cmdline.nvim" }
plugin.name = "fine-cmdline"

plugin.dependencies = {
	"MunifTanjim/nui.nvim"
}

plugin.opts = {
	hooks = {
		after_mount = function(input)
			vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = input.bufnr })
			vim.keymap.set("i", "<C-BS>", " <CMD>stopinsert<CR>dbxi", { buffer = input.bufnr })
			vim.keymap.set("i", "<C-a>", "<C-o>^", { buffer = input.bufnr })
			vim.keymap.set("i", "<C-e>", "<C-o>$", { buffer = input.bufnr })
		end
	},
	popup = {
		buf_options = { filetype = "FineCmdlinePrompt" },
		position = { row = "1%" },
		border = {
			padding = { 0, 0 },
			text = {
				top = ">>",
				top_align = "left",
				bottom = "FineCmdline",
				bottom_align = "right",
			}
		}
	}
}

plugin.init = function()
	local ft_excluded = { "qf" }
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = { "*" },
		callback = function(ev)
			local ft = ev.match
			if not vim.list_contains(ft_excluded, ft) then
				vim.keymap.set("n", "<CR>", "<CMD>FineCmdline<CR>", { buffer = ev.buf })
			end
		end
	})
end

return plugin
