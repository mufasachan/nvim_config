local vimtex = { "lervag/vimtex" }
function vimtex.init()
	vim.g.vimtex_view_general_viewer = "sioyek"
	vim.g.vimtex_quickfix_mode = 0
	vim.g.vimtex_compiler_latexrun_engines = {
		_ = "xelatex",
		pdflatex = "pdflatex",
		lualatex = "lualatex",
		xelatex = "xelatex",
	}
end

local plugins = { vimtex, "barreiroleo/ltex_extra.nvim" }
return plugins
