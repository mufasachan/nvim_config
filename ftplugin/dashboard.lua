-- Copy/paste/adapted from dashboard
-- fabf5feec96185817c732d47d363f34034212685
-- TODO: Disable illuminate and/or just the hl group for the line for the current buffer only.
-- only commit when it's done

local keys = { "w", "f", "b", "h", "l", "<Left>", "<Right>" }
vim.tbl_map(function(key)
  vim.api.nvim_buf_set_keymap(0, "n", key, "<NOP>", {})
end, keys)
