local M = { "rcarriga/nvim-dap-ui" }
M.dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }

--- @type dapui.Config
---@diagnostic disable-next-line: missing-fields
M.opts = {
  controls = { enabled = false },
  layouts = {
    {
      elements = {
        { id = "scopes",      size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks",      size = 0.25 },
        { id = "watches",     size = 0.25 },
      },
      position = "left",
      size = 40
    },
    {
      elements = {
        { id = "repl", size = 1 },
      },
      position = "bottom",
      size = 13
    },
  }
}

M.config = function(_, opts)
  local dap, dapui = require("dap"), require("dapui")
  dapui.setup(opts)

  dap.listeners.before.attach.dapui_config = function() dapui.open() end
  dap.listeners.before.launch.dapui_config = function() dapui.open() end
  dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
  dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

  require("which-key").add {
    { "<Leader>Du",  group = "UI", },
    { "<Leader>Duo", dapui.open,   desc = "Open" },
    { "<Leader>Duc", dapui.close,  desc = "Close" },
  }
end

return M
