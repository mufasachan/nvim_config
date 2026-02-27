local M               = { "nvim-treesitter/nvim-treesitter" }
M.name                = "treesitter"

M.branch              = "main"
M.build               = ":TSUpdate"

local excluded_hl     = {}
local excluded_fold   = { "dart" }
local excluded_indent = {}

function M.config()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
      local treesitter = require "nvim-treesitter"
      if vim.list_contains(treesitter.get_installed(), args.match) then
        if not vim.list_contains(excluded_hl, args.match) then
          vim.treesitter.start(args.buf, args.match)
        end
        if not vim.list_contains(excluded_fold, args.match) then
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
        end
        if not vim.list_contains(excluded_indent, args.match) then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      elseif vim.list_contains(treesitter.get_available(), args.match) then
        vim.notify('No TS installed, parser available. Use ":TSInstall ' .. args.match .. '".')
      end
    end
  })
end

return M
