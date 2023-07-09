return {
  "folke/lazy.nvim",
  init = function ()
		vim.keymap.set("n", "<Leader>L", "<CMD>Lazy<CR>", {desc = "Lazy"})
  end,
}
