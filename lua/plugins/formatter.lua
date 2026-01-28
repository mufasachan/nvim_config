local M = { "stevearc/conform.nvim" }
M.name = "conform"

M.event = { "BufWritePre" }
M.cmd = { "ConformInfo" }

-- command disable autoformat?
-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save

-- in project's .nvim.lua with specific formatters, overwrite default configuration
-- conform.formatters_by_ft.python = { "yapf", "isort", "docformatter" }

-- force CLI argument if not configured in standard files by the project
-- conform.formatters.docformatter = vim.tbl_deep_extend(
--   "force",
--   conform.formatters.docformatter or {},
--   {
--     prepend_args = { "--wrap-descriptions", "79" }
--   }
-- )

M.opts = {
	formatters_by_ft = { python = { "ruff_organize_import", "ruff_format" } },
	format_on_save = function(bufnr)
		if vim.b[bufnr].disable_autoformat then
			return
		end

		local filename = vim.fs.basename(vim.api.nvim_buf_get_name(0))
		if filename == "lazy-lock.json" then
			return
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
}

function M.config(plugin, opts)
	local conform = require(plugin.name)
	conform.setup(opts)

	require("which-key").add({
		"<Leader>f",
		function()
			conform.format({ async = true })
		end,
		desc = "Format buffer",
	})
end

return M
