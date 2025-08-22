local M = { "ibhagwan/fzf-lua" }
M.dependencies = { "nvim-tree/nvim-web-devicons" }

M.opts = {}

M.config = function(_, opts)
  require("fzf-lua").setup(opts)

  require("which-key").add {
    { "gf",         "<CMD>FzfLua files<CR>",   silent = true },
    { "<Leader>fb", "<CMD>FzfLua buffers<CR>", silent = true },
  }
end

return M
