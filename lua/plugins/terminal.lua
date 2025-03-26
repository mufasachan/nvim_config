local plugin = { "akinsho/toggleterm.nvim" }

plugin.config = true

function plugin.init()
	local map = vim.keymap.set
	map("n", "<M-1>", ":1ToggleTerm size=5 direction=horizontal<CR>")
	map("n", "<M-2>", ":2ToggleTerm direction=float<CR>")

	function _G.set_terminal_keymaps()
		map("t", "<C-Tab>", [[<C-\><C-n>]])
		map("t", "<C-PageUp>", "<CMD>tabp<CR>")
		map("t", "<C-PageDown>", "<CMD>tabn<CR>")
		map("t", "jk", [[<C-\><C-n>]])
		-- On my tablet, I only use one orientation.
		map("t", "<C-k>", "<Cmd>wincmd k<CR>")
		map("t", "<M-BS>", "<Cmd>ToggleTerm<CR>")
	end

	_G.set_terminal_keymaps()
end

return plugin
