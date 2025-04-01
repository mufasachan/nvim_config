local vimtex = { "lervag/vimtex" }
function vimtex.init()
  vim.g.vimtex_view_general_viewer = "sioyek"
  vim.g.vimtex_quickfix_mode = 0
  vim.g.vimtex_compiler_latexmk = {
    aux_dir = "aux",
    out_dir = "out",
  }
  vim.g.vimtex_compiler_latexmk_engines = {
    -- Doc say context + luatex
    _ = "-lualatex"
  }
end

local plugins = { vimtex, "barreiroleo/ltex_extra.nvim" }
return plugins
