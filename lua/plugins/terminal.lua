local M = { "akinsho/toggleterm.nvim" }

M.opts = {}

function M.init()
  local wk = require("which-key")
  wk.add {
    { "<M-1>",     ":2ToggleTerm size=5 direction=horizontal<CR>" },
    { "<M-2>",     ":2ToggleTerm size=5 direction=float<CR>" },
    { "<Leader>T", "<CMD>TermNew direction=tab<CR>" },
    { "<Leader>L", function()
      vim.cmd('TermExec direction=tab name=lg cmd="lazygit"')
      vim.defer_fn(function()
        vim.cmd("startinsert!")
      end, 50)
    end, desc = "Lazygit" }
  }

  function _G.set_terminal_keymaps()
    wk.add {
      { mode = "t", lhs = "<C-Esc>",      rhs = [[<C-\><C-n>]] },
      { mode = "t", lhs = "<C-PageUp>",   rhs = "<CMD>tabp<CR>" },
      { mode = "t", lhs = "<C-PageDown>", rhs = "<CMD>tabn<CR>" },
    }
  end

  _G.set_terminal_keymaps()
end

return M
