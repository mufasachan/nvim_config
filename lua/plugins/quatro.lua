local M = { "quarto-dev/quarto-nvim" }

M.dependencies = { "treesitter", "otter" }
M.ft = { "markdown" }

M.opts = { -- molten.nvim configuration
  lspFeatures = {
    -- NOTE: put whatever languages you want here:
    languages = { "python" },
    chunks = "all",
    diagnostics = {
      enabled = true,
      triggers = { "BufWritePost" },
    },
    completion = {
      enabled = true,
    },
  },
  keymap = {
    -- NOTE: setup your own keymaps:
    hover = "H",
    definition = "gd",
    rename = "grn",
    references = "grr",
    format = "<leader>gf",
  },
  codeRunner = {
    enabled = true,
    default_method = "molten",
  },
}

return M
