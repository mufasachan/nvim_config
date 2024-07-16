local function neovide_setup()
	vim.g.neovide_fullscreen = true
	local function _toggle_fullscreen()
		vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
	end
	vim.keymap.set("n", "<C-F11>", _toggle_fullscreen)

	vim.g.neovide_cursor_vfx_mode = ""
	vim.o.guifont = "FiraCode Nerd Font:h16"
	vim.g.neovide_transparency = 0.9
	vim.g.neovide_cursor_animation_length = 0.1

	vim.api.nvim_set_keymap("i", "<SC-V>", "<C-R>+", { noremap = true })
end

if vim.g.neovide then
	neovide_setup()
end
