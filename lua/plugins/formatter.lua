local M = { "stevearc/conform.nvim" }
M.name = "conform"

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
  formatters_by_ft = { python = { "ruff_organize_import", "ruff_format", } },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

return M
