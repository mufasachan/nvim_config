local M = { "3rd/image.nvim" }
M.tag = "v1.5.1"
M.pin = true
M.name = "image"

M.opts = {
  backend = "kitty",
  max_width = 100,                                                 -- (molten.nvim)
  max_height = 12,                                                 -- ^
  max_height_window_percentage = math.huge,                        -- ^
  max_width_window_percentage = math.huge,                         -- ^
  window_overlap_clear_enabled = true,                             -- ^
  window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" }, -- ^
}

return M
