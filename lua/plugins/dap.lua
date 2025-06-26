local M = { "mfussenegger/nvim-dap" }

M.config = function()
  local dap = require("dap")

  -- DapBreakpoint is set in rose-pine since its options are handy for this
  vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "⚬", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapLogPoint", { text = "󰍩", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "➤", texthl = "DapBreakpoint", linehl = "", numhl = "" })

  --- some should moved to dap-ui?
  require("which-key").add {
    { "<Leader>D",   group = "Debug" },
    { "<Leader>Dc",  dap.continue,                                                                        desc = "Continue" },
    { "<Leader>Dn",  dap.step_over,                                                                       desc = "Step Over" },
    { "<Leader>Di",  dap.step_into,                                                                       desc = "Step Into" },
    { "<Leader>Do",  dap.step_out,                                                                        desc = "Step Out" },
    { "<Leader>Dr",  dap.restart,                                                                         desc = "Restart" },
    { "<Leader>Dt",  dap.terminate,                                                                       desc = "Terminate" },
    { "<Leader>Dl",  dap.run_last,                                                                        desc = "Run last" },
    { "<Leader>Db",  group = "Breakpoints" },
    { "<Leader>Dbb", dap.toggle_breakpoint,                                                               desc = "Toggle Breakpoint" },
    { "<Leader>Dbl", function() dap.toggle_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "Toggle Logpoint" },
    { "<Leader>Dbc", dap.clear_breakpoints,                                                               desc = "Clear" },
  }
end

return M
