local wk = require "which-key"
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP keymaps",
  callback = function(event)
    wk.add({
      { "gd", vim.lsp.buf.definition,  buffer = event.buf },
      { "gD", vim.lsp.buf.declaration, buffer = event.buf },
    })
  end
})

vim.api.nvim_create_autocmd("BufWrite", {
  callback = function()
    if vim.lsp.get_clients({ bufnr = 0, method = "textDocument/formatting" }) then
      vim.lsp.buf.format()
    end
  end
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

local startup_group = vim.api.nvim_create_augroup("Startup", {})
local argv = vim.fn.argv()

-- No args -> dashboard should be displayed.
if #argv == 0 then
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.cmd("Dashboard")
    end,
    group = startup_group,
  })
else
  local stat = vim.uv.fs_stat(argv[1])
  if stat and stat.type == "directory" then
    vim.cmd.cd(argv[1])
    vim.cmd.SessionManager("load_current_dir_session")
  end
end
