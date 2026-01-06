local wk = require("which-key")

local function zz_horizontal()
  local cursor_col = vim.fn.col(".")
  local win_width = vim.fn.winwidth(0)
  local view = vim.fn.winsaveview()

  local target_leftcol = cursor_col - math.floor(win_width / 2)

  if target_leftcol < 0 then
    target_leftcol = 0
  end

  view.leftcol = target_leftcol
  vim.fn.winrestview(view)
end

local function yank_buffername()
  local bufname = vim.fn.bufname("%")

  if vim.uv.fs_stat(bufname) then
    bufname = vim.fs.relpath(bufname, vim.uv.cwd() or "/") or bufname
  end
  vim.fn.setreg("\"", vim.fn.bufname("%"))
end

--- @param direction "up" | "down"
--- @return fun(): nil
local function scroll_zz(direction)
  local function _scroll_zz()
    local height = vim.api.nvim_win_get_height(0)
    local amount
    if height >= 30 then
      amount = height - 3
    elseif height >= 18 then
      amount = height - 2
    else
      amount = height - 1
    end

    local cursor = vim.api.nvim_win_get_cursor(0)
    if direction == "down" then
      vim.api.nvim_win_set_cursor(0, {
        math.min(cursor[1] + amount, vim.api.nvim_buf_line_count(0)),
        cursor[2]
      })
    else
      vim.api.nvim_win_set_cursor(0, {
        math.max(1, cursor[1] - amount),
        cursor[2]
      })
    end
    vim.cmd("normal! zz")
  end

  return _scroll_zz
end

wk.add {
  -- Common
  { "<Leader>q",     "<CMD>q<CR>",       desc = "Quit",                                    hidden = true },
  { "<Leader>w",     "<CMD>w<CR>",       desc = "Save",                                    silent = true, hidden = true },
  { "<Leader><C-d>", "<CMD>enew<CR>",    desc = "Create draft",                            silent = true },
  -- Back to previous buffer
  { "<Leader>b",     "<CMD>b#<CR>",      desc = "Previous buffer" },
  { "<Leader>c",     yank_buffername,    desc = "Yank buffer name" },
  -- No register for x
  { mode = "nx",     lhs = "x",          rhs = '"_x' },
  -- jk is Esc
  { mode = "i",      lhs = "jk",         rhs = "<ESC>" },
  -- better go/up
  { "<S-Up>",        scroll_zz("up"),    silent = true },
  { "<S-Down>",      scroll_zz("down"),  silent = true },
  { mode = "nx",     "j",                "v:count == 0 ? 'gj' : 'j'",                      silent = true, expr = true },
  { mode = "nx",     "k",                "v:count == 0 ? 'gk' : 'k'",                      silent = true, expr = true },
  -- Split navigation
  { "<C-h>",         "<C-w>h",           remap = true },
  { "<C-j>",         "<C-w>j",           remap = true },
  { "<C-k>",         "<C-w>k",           remap = true },
  { "<C-l>",         "<C-w>l",           remap = true },
  { "<C-Left>",      "<C-w>h",           remap = true },
  { "<C-Down>",      "<C-w>j",           remap = true },
  { "<C-Up>",        "<C-w>k",           remap = true },
  { "<C-Right>",     "<C-w>l",           remap = true },
  { "<A-j>",         "<CMD>m .+1<CR>==", silent = true },
  { "<A-k>",         "<CMD>m .-2<CR>==", silent = true },
  -- Move lines
  { mode = "i",      "<A-j>",            "<ESC><CMD>m .+1<CR>==",                          silent = true },
  { mode = "i",      "<A-k>",            "<ESC><CMD>m .-2<CR>==",                          silent = true },
  { mode = "v",      "<A-j>",            ":m '>+1<cr>gv=gv",                               silent = true },
  { mode = "v",      "<A-k>",            ":m '<-2<cr>gv=gv",                               silent = true },
  { "zZ",            zz_horizontal,      desc = "Scroll horizontal center (similar to zz)" },

}
