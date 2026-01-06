local M = { "ibhagwan/fzf-lua" }
M.dependencies = { "nvim-tree/nvim-web-devicons" }

local function yank_filename(selected, _)
  local separator = string.char(0xE2, 0x80, 0x82)
  local filename = string.sub(selected[1], string.find(selected[1], separator, 1, true) + 3)
  vim.fn.setreg("\"", vim.fs.basename(filename))
end

local function yank_absolute(selected, _)
  local separator = string.char(0xE2, 0x80, 0x82)
  local filename = string.sub(selected[1], string.find(selected[1], separator, 1, true) + 3)
  vim.fn.setreg("\"", vim.fs.abspath(filename))
end

local function yank_relative(selected, _)
  local separator = string.char(0xE2, 0x80, 0x82)
  local filename = string.sub(selected[1], string.find(selected[1], separator, 1, true) + 3)
  vim.fn.setreg("\"", filename)
end

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
      ["ctrl-y"] = yank_relative,
      ["ctrl-alt-y"] = yank_absolute,
      ["alt-y"] = yank_filename,
    }
  },
  oldfiles = {
    include_current_session = true,
    actions = {
      ["ctrl-y"] = yank_relative,
      ["ctrl-alt-y"] = yank_absolute,
      ["ctrl-e"] = yank_filename,
    },
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
    { "gB",              "<CMD>FzfLua dap_breakpoints<CR>",       silent = true, desc = "DAP Breakpoints" },
    { "gS",              "<CMD>FzfLua lsp_workspace_symbols<CR>", silent = true, desc = "Workspace symbols" },
    { group = "Pickers", "<Leader>p" },
    { "<Leader>ph",      "<CMD>FzfLua helptags<CR>",              silent = true, desc = "Help tags" },
    { "<Leader>pT",      "<CMD>FzfLua colorschemes<CR>",          silent = true, desc = "Colorschemes" },
    { "<Leader>pk",      "<CMD>FzfLua keymaps<CR>",               silent = true, desc = "Keymaps" },
    { "<Leader>pg",      "<CMD>FzfLua live_grep<CR>",             silent = true, desc = "Live GREP" },
    { "<Leader>pf",      "<CMD>FzfLua grep_curbuf<CR>",           silent = true, desc = "grep (current buffer)" },
    { "<Leader>pb",      "<CMD>FzfLua buffers<CR>",               silent = true, desc = "Buffers" },
  }
  local config = require("fzf-lua.config")
  local actions = require("trouble.sources.fzf").actions
  config.defaults.actions.files["ctrl-t"] = actions.open
end

return M
