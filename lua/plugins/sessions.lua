-- Also see welcome.lua module for setting of "startup loading"
-- dashboard is coupled between its start and set its opts.
-- Thus, the VimEnter loading is defined there.
local plugin = { "Shatur/neovim-session-manager" }
plugin.dependencies = { "plenary", "which-key" }

plugin.opts = {
	autosave_ignore_filetypes = {
		"gitcommit",
		"gitrebase",
		"dashboard",
		"NvimTree"
	},
}

function plugin.config(_, opts)
	local config = require("session_manager.config")
	opts.autoload_mode = { config.AutoloadMode.Disabled }

	require("which-key").add({
		{ lhs = "<Leader>s", rhs = "<CMD>SessionManager load_session<CR>", desc = "Sessions", silent = true }
	})

	require("session_manager").setup(opts)
end

return plugin
