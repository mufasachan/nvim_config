-- Copy/paste/adapted from dashboard
-- fabf5feec96185817c732d47d363f34034212685
-- TODO: Disable illuminate and/or just the hl group for the line for the current buffer only.
-- only commit when it's done
local function disable_move_and_cursor()
  -- No move
  local keys = { "w", "f", "b", "h", "l", "<Left>", "<Right>" }
  vim.tbl_map(function(key)
    vim.api.nvim_buf_set_keymap(0, "n", key, "<NOP>", {})
  end, keys)
end

disable_move_and_cursor()
vim.o.laststatus = 0
vim.o.cmdheight = 0
