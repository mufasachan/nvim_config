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

local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf" },
  group = group,
  desc = [[
		q for Quitting
		Focus top window (help window)
		resize help page as it was before
		NOTE: C-W + C-O set the help page on the window.
	]],
  command = 'nnoremap <buffer> q <CMD>quit<CR><C-W>k<CMD>exe "resize " . &helpheight<CR>'
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf" },
  group = group,
  desc = [[
		<CR> Close the qf window
		NOTE: C-W + C-O set the help page on the window.
	]],
  --                                        Close qf    Resize help page to its default size
  command = 'nnoremap <buffer> <CR> <CR><CMD>lclose<CR><CMD>exe "resize " . &helpheight<CR>'
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man" },
  group = group,
  command = "nnoremap <buffer> q <cmd>quit<cr>"
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
