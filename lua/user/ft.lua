vim.api.nvim_create_autocmd(
	{ "BufRead", "BufNewFile" },
	{ pattern = { "*.bash_*" }, command = "set ft=bash" }
)
