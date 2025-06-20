local M = { "yetone/avante.nvim" }
-- no need for local cargo
M.build = "make"

M.event = "VeryLazy"
M.version = false
M.dependencies = {
  "treesitter",
  "plenary",
  "MunifTanjim/nui.nvim",
  "telescope",              -- for file_selector provider telescope
  "hrsh7th/nvim-cmp",       -- TODO replace with blink
  "stevearc/dressing.nvim", -- for input provider dressing
}

---@module 'avante'
---@type avante.Config
M.opts = {
  provider = "openai",
  providers = {
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4.1-mini",
      timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      extra_request_body = {
        temperature = 0.75,
        max_completion_tokens = 16384, -- Increase this to include reasoning tokens (for reasoning models)
      },
    },
  },
}

return M
