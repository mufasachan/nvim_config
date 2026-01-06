local plugin = { "folke/which-key.nvim" }
plugin.name = "which-key"

plugin.dependencies = { "nvim-web-devicons" }

plugin.opts = {
  preset = "modern",
  delay = 200,
  plugins = {
    marks = false,
    registers = false,
    spelling = { enabled = false },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = false,
      nav = false,
      z = false,
      g = false,
    },
  },
  triggers = {
    { "<Leader>", mode = { "n" } },
    { "gr",       mode = { "n" } }
  },
  icons = { rules = false },
}

plugin.event = "VeryLazy"

return plugin
