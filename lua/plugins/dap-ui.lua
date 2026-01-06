local M = { "rcarriga/nvim-dap-ui" }
M.dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }

--- @type dapui.Config
---@diagnostic disable-next-line: missing-fields
M.opts = {
  controls = { enabled = false },
}


M.config = function(_, opts)
  local dap, dapui = require("dap"), require("dapui")
  dapui.setup(opts)

  local bufnr_stack = nil
  local function focus_stack()
    if not dap.session() then return end

    -- if no buffer, search for it
    if not bufnr_stack then
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_get_option_value("filetype", { buf = bufnr }):match("stacks") then
          bufnr_stack = bufnr
        end
      end
    end

    -- case: session but no buffer with stack?
    if not bufnr_stack then return end

    if vim.api.nvim_get_option_value("bufhidden", { buf = bufnr_stack }) then
      dapui.open()
    end
    for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if bufnr_stack == vim.api.nvim_win_get_buf(winid) then
        vim.api.nvim_set_current_win(winid)
      end
    end
  end

  local bufnr_terminal = nil
  local function focus_terminal()
    if not dap.session() then return end

    -- if no buffer, search for it
    if not bufnr_terminal then
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_get_option_value("filetype", { buf = bufnr }):match("console") then
          bufnr_terminal = bufnr
        end
      end
    end

    -- case: session but no buffer with stack?
    if not bufnr_terminal then return end

    if vim.api.nvim_get_option_value("bufhidden", { buf = bufnr_terminal }) then
      dapui.open()
    end
    for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if bufnr_terminal == vim.api.nvim_win_get_buf(winid) then
        vim.api.nvim_set_current_win(winid)
      end
    end
  end

  local bufnr_breakpoints = nil
  local function focus_breakpoints()
    if not dap.session() then return end

    -- if no buffer, search for it
    if not bufnr_breakpoints then
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_get_option_value("filetype", { buf = bufnr }):match("breakpoints") then
          bufnr_breakpoints = bufnr
        end
      end
    end

    -- case: session but no buffer with stack?
    if not bufnr_breakpoints then return end

    if vim.api.nvim_get_option_value("bufhidden", { buf = bufnr_breakpoints }) then
      dapui.open()
    end
    for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if bufnr_breakpoints == vim.api.nvim_win_get_buf(winid) then
        vim.api.nvim_set_current_win(winid)
      end
    end
  end

  local bufnr_repl = nil
  local function focus_repl()
    if not dap.session() then return end

    -- if no buffer, search for it
    if not bufnr_repl then
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_get_option_value("filetype", { buf = bufnr }):match("repl") then
          bufnr_repl = bufnr
        end
      end
    end

    -- case: session but no buffer with stack?
    if not bufnr_repl then return end

    if vim.api.nvim_get_option_value("bufhidden", { buf = bufnr_repl }) then
      dapui.open()
    end
    for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      if bufnr_repl == vim.api.nvim_win_get_buf(winid) then
        vim.api.nvim_set_current_win(winid)
      end
    end
  end


  dap.listeners.before.attach.dapui_config = function() dapui.open() end
  dap.listeners.before.launch.dapui_config = function() dapui.open() end
  function dap.listeners.before.event_exited.dapui_config()
    dapui.close()
    bufnr_stack, bufnr_repl = nil, nil
  end

  function dap.listeners.before.event_terminated.dapui_config()
    dapui.close()
    bufnr_breakpoints, bufnr_stack, bufnr_repl = nil, nil, nil
  end

  require("which-key").add {
    { "<Leader>du",  group = "UI", },
    { "<Leader>duo", dapui.open,        desc = "Open" },
    { "<Leader>dus", focus_stack,       desc = "Focus Staks" },
    { "<Leader>dur", focus_repl,        desc = "Focus REPL" },
    { "<Leader>dub", focus_breakpoints, desc = "Focus Breakpoints" },
    { "<Leader>dut", focus_terminal,    desc = "Focus Terminal" },
    { "<Leader>duc", dapui.close,       desc = "Close" },
  }
end

return M
