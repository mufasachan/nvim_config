if vim.g.neovide then
  vim.g.neovide_fullscreen = true
  local function _toggle_fullscreen()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end
  vim.keymap.set("n", "<C-F11>", _toggle_fullscreen)

  vim.g.neovide_cursor_vfx_mode = ""
  vim.o.guifont = "GeistMono Nerd Font Mono:h18"
  vim.g.neovide_opacity = 0.9
  vim.g.neovide_cursor_animation_length = 0

  vim.api.nvim_set_keymap("i", "<SC-V>", "<C-R>+", { noremap = true })
end
