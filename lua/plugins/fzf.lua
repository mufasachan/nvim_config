local M = { "ibhagwan/fzf-lua" }
M.dependencies = { "nvim-tree/nvim-web-devicons" }

local function search_parent_folder(_, opts)
  require("fzf-lua").files { cwd = vim.fs.dirname(opts.cwd or vim.uv.cwd()) }
end

local function search_current_buffer_parent_confirm()
  vim.fn.feedkeys(":FzfLua files cwd=" .. vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
end

local function search_current_buffer_parent()
  require("fzf-lua").files { cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) }
end

M.opts = {
  fzf_opts = {
    ["--cycle"] = true,
  },
  files = {
    actions = {
      ["alt-u"] = search_parent_folder,
    }
  },
  oldfiles = {
    include_current_session = true,
    winopts = {
      preview = {
        layout = "vertical",
        vertical = "down:65%",
      },
    },
  },
  grep = {
    fzf_opts = {
      ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history",
    },
  },
}

M.config = function(_, opts)
  require("fzf-lua").setup(opts)

  require("which-key").add {
    { [[<C-\>]],         "<CMD>FzfLua global<CR>",                silent = true },
    { "<Leader>r",       "<CMD>FzfLua resume<CR>",                silent = true, desc = "Resume fzf" },
    { "<Leader>?",       "<CMD>FzfLua oldfiles<CR>",              silent = true, desc = "Old files" },
    { "gf",              "<CMD>FzfLua files<CR>",                 silent = true },
    { "gp",              search_current_buffer_parent,            silent = true },
    { "gP",              search_current_buffer_parent_confirm,    silent = true },
    { "gs",              "<CMD>FzfLua lsp_document_symbols<CR>",  silent = true, desc = "Document symbols" },
    { "gS",              "<CMD>FzfLua lsp_workspace_symbols<CR>", silent = true, desc = "Workspace symbols" },
    { group = "Pickers", "<Leader>p" },
    { "<Leader>ph",      "<CMD>FzfLua helptags<CR>",              silent = true, desc = "Help tags" },
    { "<Leader>pg",      "<CMD>FzfLua live_grep<CR>",             silent = true, desc = "Live GREP" },
    { "<Leader>pf",      "<CMD>FzfLua grep_curbuf<CR>",           silent = true, desc = "grep (current buffer)" },
    { "<Leader>pb",      "<CMD>FzfLua buffers<CR>",               silent = true, desc = "Buffers" },
  }
end

return M
