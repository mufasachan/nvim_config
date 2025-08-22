local M = { "mfussenegger/nvim-dap" }

-- Missings todo from higher priority to low one
--  TODO normal mode powered while debugging set sort of debugleader?
--    QUESTION Just use `\` as debug leader and move all the remap there.
--      * More, when session, change the mapping available? *
--    [ ] quick go to thread
--    [ ] quick go to repl
--    [ ] UI
--      [ ] toggle terminal and repl
--      [ ] toggle left layouts
--    [ ] continue, step into, out easy keymapping
--    [ ] debug until cursor position
--  TODO better call hierarchy: not much details about it, no details of the call stack
--  TODO virtual text for the lolz
--    use on_session and stuff like that to setup stuff and listener
--  TODO dapui in a tab

M.config = function()
  local dap = require("dap")

  -- DapBreakpoint is set in rose-pine since its options are handy for this
  vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "⚬", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapLogPoint", { text = "󰍩", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "➤", texthl = "DapBreakpoint", linehl = "", numhl = "" })

  --- some should moved to dap-ui?
  require("which-key").add {
    { "<Leader>D",       group = "Debug" },
    { "<Leader>Dc",      dap.continue,                                                                     desc = "Continue" },
    { "<Leader>Dn",      dap.step_over,                                                                    desc = "Step Over" },
    { "<Leader>Di",      dap.step_into,                                                                    desc = "Step Into" },
    { "<Leader>Do",      dap.step_out,                                                                     desc = "Step Out" },
    { "<Leader>Dr",      dap.run_to_cursor,                                                                desc = "Run to Cursor" },
    { "<Leader>DR",      dap.restart,                                                                      desc = "Restart" },
    { "<Leader>Dt",      dap.terminate,                                                                    desc = "Terminate" },
    { "<Leader>Dl",      dap.run_last,                                                                     desc = "Run last" },
    { "<Leader>D<Up>",   dap.up,                                                                           desc = "Up" },
    { "<Leader>D<Down>", dap.down,                                                                         desc = "Down" },
    { "<Leader>DL",      "<CMD>e .vscode/launch.json<CR>",                                                 desc = "Open launch.json" },
    { "<Leader>Db",      group = "Breakpoints" },
    { "<Leader>Dbb",     dap.toggle_breakpoint,                                                            desc = "Toggle Breakpoint" },
    { "<Leader>Dbl",     function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "Set Logpoint" },
    { "<Leader>Dbc",     function() dap.set_breakpoint(vim.fn.input("Condition: "), nil, nil) end,         desc = "Set Conditional Breakpoint" },
    { "<Leader>Dbd",     dap.clear_breakpoints,                                                            desc = "Delete all" },
  }
end

return M
