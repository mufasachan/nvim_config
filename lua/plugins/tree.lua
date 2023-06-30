local map = vim.keymap.set
local del = vim.keymap.del

map("n", "<leader>ee", ":NvimTreeToggle<cr>", { desc = "Open", silent = true})
map("n", "<leader>eE", ":NvimTreeFindFile<cr>", { desc = "Open: Focus current file", silent = true})
local function on_attach_tree(bufnr)
  local api = require'nvim-tree.api'

  local function opts(desc)
    return {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true
    }
  end

  api.config.mappings.default_on_attach(bufnr)
  del('n', '<2-LeftMouse>', {buffer = bufnr})
  del('n', '<2-RightMouse>', {buffer = bufnr})
  del('n', '<', {buffer = bufnr})
  del('n', '>', {buffer = bufnr})
  del('n', 'W', {buffer = bufnr})
  del('n', '<CR>', {buffer = bufnr})
  del('n', '<BS>', {buffer = bufnr})
  del('n', 'e', {buffer = bufnr})
  del('n', 'r', {buffer = bufnr})
  del('n', '<C-R>', {buffer = bufnr})

  map("n", "l", api.node.open.edit, opts('Open'))
  map("n", "e", api.node.open.edit, opts('Open'))
  map("n", "rr", api.fs.rename, opts('Rename'))
  map("n", "re", api.fs.rename_basename, opts('Rename: Basename'))
  map("n", "ro", api.fs.rename_sub, opts('Rename: Omit Filename'))

end
local opts_tree = {
  on_attach = on_attach_tree,
  sort_by = "case_sensitive",
  view = {width = 30},
  renderer = {group_empty = true},
  filters = {dotfiles = true},
}

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {"nvim-tree/nvim-web-devicons"},
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup(opts_tree)
  end
}

