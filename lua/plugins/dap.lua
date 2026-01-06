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
    { "<Leader>d",       group = "Debug" },
    { "<Leader>dc",      dap.continue,                                                                     desc = "Continue" },
    { "<Leader>dn",      dap.step_over,                                                                    desc = "Step Over" },
    { "<Leader>di",      dap.step_into,                                                                    desc = "Step Into" },
    { "<Leader>do",      dap.step_out,                                                                     desc = "Step Out" },
    { "<Leader>df",      dap.focus_frame,                                                                  desc = "Focus frame" },
    { "<Leader>dj",      function() dap.goto_(nil) end,                                                    desc = "Jump to Cursor" },
    { "<Leader>dr",      dap.run_to_cursor,                                                                desc = "Run to Cursor" },
    { "<Leader>dR",      dap.restart,                                                                      desc = "Restart" },
    { "<Leader>dt",      dap.terminate,                                                                    desc = "Terminate" },
    { "<Leader>dl",      dap.run_last,                                                                     desc = "Run last" },
    { "<Leader>d<Up>",   dap.up,                                                                           desc = "Up" },
    { "<Leader>d<Down>", dap.down,                                                                         desc = "Down" },
    { "<Leader>dL",      "<CMD>e .vscode/launch.json<CR>",                                                 desc = "Open launch.json" },
    { "<Leader>db",      group = "Breakpoints" },
    { "<Leader>dbb",     dap.toggle_breakpoint,                                                            desc = "Toggle Breakpoint" },
    { "<Leader>dbl",     function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "Set Logpoint" },
    { "<Leader>dbc",     function() dap.set_breakpoint(vim.fn.input("Condition: "), nil, nil) end,         desc = "Set Conditional Breakpoint" },
    { "<Leader>dbd",     dap.clear_breakpoints,                                                            desc = "Delete all" },
  }
end

return M
