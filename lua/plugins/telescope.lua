-- Set hidden files but not .git in vimgrep
-- local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }
-- table.insert(vimgrep_arguments, "--hidden")
-- table.insert(vimgrep_arguments, "--glob")
-- table.insert(vimgrep_arguments, "!**/.git/*")
-- plugin.opts.defaults.vimgrep_arguments = vimgrep_arguments
local plugin = { "nvim-telescope/telescope.nvim" }
plugin.name = "telescope"

plugin.dependencies = { "nvim-web-devicons" }

plugin.dependencies = {
  "plenary",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}

plugin.opts = {
  defaults = {
    mappings = {
      n = { ["q"] = "close" },
      i = {
        ["kj"] = "close",
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { "fd", "-H", "-I", "-E", ".mypy_cache", "-E", ".venv", "-E", ".git", "--type", "f" },
    }
  },
}

function plugin.config()
  local telescope = require "telescope"

  local wk = require "which-key"
  wk.add {
    { "gf",         ":Telescope find_files<CR>",                silent = true, desc = "Find files" },
    { "<leader>?",  ":Telescope oldfiles<CR>",                  silent = true, desc = "Recent files" },
    { "<leader>fg", ":Telescope live_grep<CR>",                 silent = true, desc = "Live GREP" },
    { "<leader>fh", ":Telescope help_tags<CR>",                 silent = true, desc = "Help tags" },
    { "<leader>ft", ":Telescope pickers<CR>",                   silent = true, desc = "Pickers" },
    { "gb",         ":Telescope buffers<CR>",      silent = true, desc = "Document symbols" },
    { "gs",         ":Telescope lsp_document_symbols<CR>",      silent = true, desc = "Document symbols" },
    { "gS",         ":Telescope lsp_workspace_symbols<CR>",     silent = true, desc = "Workspace symbols" },
    { "<leader>ff", ":Telescope current_buffer_fuzzy_find<CR>", silent = true, desc = "Fuzzy find" },
  }

  telescope.load_extension("fzf")
  telescope.setup(plugin.opts)
end

return plugin
