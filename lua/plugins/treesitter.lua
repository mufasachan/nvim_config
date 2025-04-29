---@diagnostic disable: missing-fields
local plugin = { "nvim-treesitter/nvim-treesitter" }
plugin.name = "treesitter"

plugin.build = {
  build = ":TSUpdate",
}

function plugin.init()
  require "nvim-treesitter.configs".setup {
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
    textobjects = { enable = true },
    indent = {
      enable = true,
      disable = { "dart" },
    },
    additional_vim_regex_highlighting = true,
  }
end

return plugin
