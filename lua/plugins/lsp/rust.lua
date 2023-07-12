local plugin = {'simrat39/rust-tools.nvim'}
plugin.opts = {}

local function on_attach()
	local group = vim.api.nvim_create_augroup('rust_cmds', {clear = true})
	vim.api.nvim_create_autocmd('FileType', {
		pattern = {'rust'},
		group = group,
		callback = function ()
			-- TODO: Unregister on leave
			require'which-key'.register({
				["<Leader>r"] = { name = "Rust"},
			})

			vim.keymap.set('n', '<Leader>rr', '<CMD>RustRunnables<CR>', {desc = 'Runnables'})
		end
	})
end

function plugin.config()
	local executors = require'rust-tools.executors'
	plugin.opts.executor = executors.toggleterm

	on_attach()

	require'rust-tools'.setup{plugin.opts}
end

return plugin
