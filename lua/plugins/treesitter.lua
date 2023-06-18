return {{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "json",
      "lua",
      "python",
      "yaml",
    },
  },
}}
