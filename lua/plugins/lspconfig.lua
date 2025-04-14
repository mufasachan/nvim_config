local plugin = { "neovim/nvim-lspconfig" }
plugin.name = "lspconfig"

plugin.dependencies = {
  { "williamboman/mason-lspconfig.nvim", lazy = true, dependencies = "mason" },
  { "williamboman/mason.nvim", name = "mason", opts = { ui = { border = "rounded" } },
  },
}

plugin.cmd = "LspInfo"
plugin.event = { "BufReadPre", "BufNewFile" }

local function lsp_keymaps()
  require "which-key".add({
    { "<Leader>F", function() vim.lsp.buf.format({ async = true }) end, buffer = 0, desc = "Format" },
  })
end

function plugin.config()
  local lspconfig = require "lspconfig"

  -- All Mason-installed LSP are enabled by default
  require("mason-lspconfig").setup_handlers {
      function (server_name)
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
