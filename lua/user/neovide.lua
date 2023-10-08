local function neovide_setup()
	vim.g.neovide_fullscreen = true
	vim.g.neovide_cursor_vfx_mode = "pixiedust"
	vim.o.guifont = "FiraCode Nerd Font:h16"
	vim.keymap.set("i", "<C-v>", '<Esc>l"+Pa', { silent = false })
end

if vim.g.neovide then
	neovide_setup()
end
