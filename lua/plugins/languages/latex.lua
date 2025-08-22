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

local ltex_extra = { "barreiroleo/ltex_extra.nvim" }
ltex_extra.opts = { path = ".ltex" }
function ltex_extra.config(_, opts)
  opts = opts or {}

  vim.lsp.config("ltex_plus", {
    on_attach = function(_, _)
      require("ltex_extra").setup(opts)
    end
  })
end

return { vimtex, ltex_extra }
