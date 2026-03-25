require("quarto").activate()

vim.g.maplocalleader = "\\"

--- Wrap a region of the current buffer in Markdown bold (`**`).
--- Inserts the closing marker first so start-position columns stay valid.
---@param sr integer  start row    (0-indexed)
---@param sc integer  start column (0-indexed)
---@param er integer  end row      (0-indexed)
---@param ec integer  end column   (0-indexed, exclusive — one past last char)
local function bold_region(sr, sc, er, ec)
  vim.api.nvim_buf_set_text(0, er, ec, er, ec, { "**" })
  vim.api.nvim_buf_set_text(0, sr, sc, sr, sc, { "**" })
end

--- Operator callback invoked by `g@` after a motion completes.
--- Reads the `[` / `]` marks that Neovim sets automatically and
--- delegates to `bold_region`. Ignores line/block-wise motions.
---@param type "char"|"line"|"block"  motion type set by `g@`
function _G._bold_operator(type)
  if type ~= "char" then return end
  local s = vim.api.nvim_buf_get_mark(0, "[")
  local e = vim.api.nvim_buf_get_mark(0, "]")
  -- Marks are 1-indexed, `nvim_buf_set_text` is 0-indexed; `]` is inclusive → +1
  bold_region(s[1] - 1, s[2], e[1] - 1, e[2] + 1)
end

--- Composable operator: `<leader>b{motion}` (e.g. `<leader>b2w`, `<leader>btf`).
--- Returns `g@` so Neovim waits for a motion before calling the operator.
require("which-key").add({
  {
    mode = "n",
    lhs = "<LocalLeader>b",
    rhs = function()
      vim.o.operatorfunc = "v:lua._bold_operator"
      return "g@"
    end,
    expr = true
  },
  {
    mode = "n",
    lhs = "<LocalLeader>bw",
    rhs = function()
      vim.o.operatorfunc = "v:lua._bold_operator"
      return "g@iw"
    end,
    expr = true
  },
  {
    mode = "x",
    lhs = "<LocalLeader>b",
    rhs = function()
      local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
      vim.api.nvim_feedkeys(esc, "x", true)
      local s = vim.api.nvim_buf_get_mark(0, "<")
      local e = vim.api.nvim_buf_get_mark(0, ">")
      bold_region(s[1] - 1, s[2], e[1] - 1, e[2] + 1)
    end,
  }
})
