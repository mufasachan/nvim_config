local M = { "nvim-treesitter/nvim-treesitter" }
M.name = "treesitter"

M.build = {
  build = ":TSUpdate",
}

M.dependencies = {
  "treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",
}

M.opts = {
  ensure_installed = {
    "gitignore",
    "c",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
    "bash",
    "json",
    "python",
    "yaml",
    "lua"
  },
  ignore_install = { "latex" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  auto_install = false,

  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = {
    move = {
      enable = true,
      disable = { "dart" },
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]c"] = "@conditional.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]C"] = "@conditional.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[c"] = "@conditional.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[C"] = "@conditional.outer",
      },
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      }
    },
  },
  indent = {
    enable = true,
    disable = { "dart" },
  },
  additional_vim_regex_highlighting = true,
}

function M.config(_, opts)
  require "nvim-treesitter.configs".setup(opts)
end

return M
