local plugin = {'Shatur/neovim-session-manager'}

plugin.dependencies = 'nvim-lua/plenary.nvim'

function plugin.config()
	local config = require'session_manager.config'
	local session_manager = require'session_manager'

	-- There are good autocommand in doc session-manager
	require'session_manager'.setup{
		-- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
		autoload_mode = config.AutoloadMode.CurrentDir,
		-- Always autosaves session. If true, only autosaves after a session is active.
		autosave_only_in_session = false,
	}
end

return plugin
