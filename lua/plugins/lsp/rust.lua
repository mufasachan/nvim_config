local plugin = {'simrat39/rust-tools.nvim'}
plugin.opts = {}

function plugin.config()
	local executors = require'rust-tools.executors'
	plugin.opts.executor = executors.toggleterm

	require'rust-tools'.setup{plugin.opts}
end

return plugin
