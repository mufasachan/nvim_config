-- q for Quitting:
--  1. Focus top window (help window)
--  2. resize help page as it was before
vim.api.nvim_buf_set_keymap(0, "n", "q", "<CMD>quit<CR><C-W>k<CMD>exe \"resize \" . &helpheight<CR>",
  { noremap = true })
