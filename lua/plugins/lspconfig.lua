local plugin = { "neovim/nvim-lspconfig" }
plugin.name = "lspconfig"

plugin.dependencies = {
  { "williamboman/mason-lspconfig.nvim", lazy = true, dependencies = "mason" },
  { "williamboman/mason.nvim", name = "mason", opts = { ui = { border = "rounded" } },
  },
}

plugin.cmd = "LspInfo"
plugin.event = { "BufReadPre", "BufNewFile" }

function plugin.config()
  local function lsp_keymaps()
    require "which-key".add({
      { "gd",        vim.lsp.buf.definition,                              buffer = 0 },
      { "gD",        vim.lsp.buf.declaration,                             buffer = 0 },
      { "<Leader>F", function() vim.lsp.buf.format({ async = true }) end, buffer = 0, desc = "Format" },
    })
  end

  -- All Mason-installed LSP are enabled by default
  require("mason-lspconfig").setup_handlers {
    function(server_name)
      if server_name == "basedpyright" then
        return
      end
      vim.lsp.enable(server_name)
    end,
  }

  -- Set generic LSP mappings
  local group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    desc = "LSP keymaps",
    callback = lsp_keymaps
  })
end

return plugin
