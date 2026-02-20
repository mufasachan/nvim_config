local M = { "MeanderingProgrammer/render-markdown.nvim" }
M.name = "render-markdown"

M.dependencies = { "treesitter", "nvim-tree/nvim-web-devicons" }
M.opts = {
  latex = { position = "above" },
  restart_highlighter = true,
  completions = { lsp = { enabled = true } },
  file_types = { "markdown" },
}

return M
