local plugin = { "rmagatti/auto-session" }
plugin.dependencies = { "telescope", "which-key", "nvim-tree" }

plugin.opts = {
	auto_restore_enabled = true,
	auto_save_enabled = true,
	args_allow_files_auto_save = true,
}

function plugin.config(_, opts)
	vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
	local search_sessions = require("auto-session.session-lens").search_session

	-- Thanks https://github.com/rmagatti/auto-session/issues/206#issuecomment-2057534051
	local close_dirbuffers = function()
		local buffers = vim.api.nvim_list_bufs()
		for i = 1, #buffers do
			local buffer_name = vim.api.nvim_buf_get_name(buffers[i])
			if vim.fn.isdirectory(buffer_name) == 1 then
				vim.api.nvim_buf_delete(buffers[i], { force = true })
			end
		end
	end
	vim.api.nvim_create_autocmd({"VimEnter"}, {
		callback = function () vim.defer_fn(close_dirbuffers, 1) end,
	})

	require("which-key").add({
		{ "<Leader>s", search_sessions, desc = "Sessions" },
	})

	require("auto-session").setup(opts)
end

return plugin
