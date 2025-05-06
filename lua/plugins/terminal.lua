local plugin = { "akinsho/toggleterm.nvim" }

plugin.config = true

function plugin.init()
  local map = vim.keymap.set
  local wk = require("which-key")
  wk.add {
    { "<M-1>", ":2ToggleTerm size=5 direction=horizontal<CR>" },
    { "<M-2>", ":2ToggleTerm size=5 direction=float<CR>" },
    { "<Leader>T", ":ToggleTerm direction=tab<CR>" }
  }

  function _G.set_terminal_keymaps()
    wk.add {
      { mode = "t", lhs = "jk",           rhs = [[<C-\><C-n>]] },
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

return plugin
