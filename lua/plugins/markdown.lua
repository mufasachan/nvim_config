local M = { "iamcco/markdown-preview.nvim" }
M.cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }
M.build = "cd app && yarn install"

function M.init()
  vim.g.mkdp_filetypes = { "markdown" }
end

M.ft = { "markdown" }

return M
