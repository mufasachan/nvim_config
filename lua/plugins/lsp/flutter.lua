local plugin = { "akinsho/flutter-tools.nvim" }
plugin.name = "flutter-tools"

-- TODOs:
-- - Rename comment is not working

plugin.dependencies = {
	"nvim-lua/plenary.nvim",
	"stevearc/dressing.nvim",
	"which-key",
}

local function on_attach()
	local wk = require "which-key"
	wk.register({
		["<Leader>L"] = { name = "Flutter" },
	})

	vim.keymap.set("n", "<Leader>Lx", "<CMD>FlutterRun<CR>", {  desc = "Run" })
	vim.keymap.set("n", "<Leader>Lh", "<CMD>FlutterReload<CR>", {  desc = "Hot reload" })
	vim.keymap.set("n", "<Leader>Lr", "<CMD>FlutterRestart<CR>", {  desc = "Restart" })
	vim.keymap.set("n", "<Leader>Lo", "<CMD>FlutterOutlineToggle<CR>", {  desc = "Outline toggle" })
	vim.keymap.set("n", "<Leader>Lq", "<CMD>FlutterQuit<CR>", {  desc = "Quit" })
end

plugin.opts = {
	flutter_path = "/home/reusm/.local/opt/flutter/bin/flutter",
	dev_tools = {
		autostart = true,       -- autostart devtools server if not detected
		auto_open_browser = false, -- Automatically opens devtools in the browser
	},
	lsp = {
		color = { -- show the derived colours for dart variables
      enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
      background = false, -- highlight the background
      background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
      foreground = false, -- highlight the foreground
      virtual_text = true, -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
		on_attach = on_attach,
		-- TODO analysisExcludedFolders
		-- settings = { }
	},
}


return plugin
