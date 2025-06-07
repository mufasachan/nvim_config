local M = { "akinsho/toggleterm.nvim" }

M.config = true

function M.init()
  local wk = require("which-key")
  wk.add {
    { "<M-1>",     ":2ToggleTerm size=5 direction=horizontal<CR>" },
    { "<M-2>",     ":2ToggleTerm size=5 direction=float<CR>" },
    { "<Leader>T", "<CMD>TermNew direction=tab<CR>" },
    { "<Leader>L", "<CMD>TermExec direction=tab name=lg cmd=lazygit<CR>" }
  }

  local laststatus_memory = nil
  vim.api.nvim_create_autocmd("TermEnter", {
    callback = function()
      laststatus_memory = vim.o.laststatus
      vim.o.laststatus = 0
    end
  })
  vim.api.nvim_create_autocmd("TermLeave", {
    callback = function()
      vim.o.laststatus = laststatus_memory
    end
  })

  function _G.set_terminal_keymaps()
    wk.add {
      { mode = "t", lhs = "<C-Esc>",      rhs = [[<C-\><C-n>]] },
      { mode = "t", lhs = "<C-PageUp>",   rhs = "<CMD>tabp<CR>" },
      { mode = "t", lhs = "<C-PageDown>", rhs = "<CMD>tabn<CR>" },
      -- On my tablet, I only use one orientation.
      { mode = "t", lhs = "<C-k>",        rhs = "<Cmd>wincmd k<CR>" },
      { mode = "t", lhs = "<M-BS>",       rhs = "<Cmd>ToggleTerm<CR>" },
    }
  end

  _G.set_terminal_keymaps()
end

return M
