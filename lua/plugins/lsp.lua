local M_mason = {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  keys = {{ "<leader>M", "<cmd>Mason<cr>", desc = "Mason"}},
  opts = {},
}

local M_mason_lspconfig = {
  "williamboman/mason-lspconfig.nvim",
  -- Plug LSPs installed by mason 
  config = function(opts)
    require("mason-lspconfig").setup_handlers {
      function (server_name)
	require("lspconfig")[server_name].setup {}
      end
    }
    require("mason-lspconfig").setup(opts)
  end,
  dependencies = M_mason
}

local M = {
  {
    "neovim/nvim-lspconfig",
    dependencies = M_mason_lspconfig,
    config = function()
      -- require("lspconfig").setup(opts)
      -- LSPs installed externally 
      require'lspconfig'.lua_ls.setup {
	settings = {
	  Lua = {
	    -- Get the language server to recognize the `vim` global
	    diagnostics = { globals = {'vim'}, },
	    -- Make the server aware of Neovim runtime files
	    workspace = { library = vim.api.nvim_get_runtime_file("", true), },
	    telemetry = {
	      enable = false,
	    },
	  },
	},
      }
      require"lspconfig".rust_analyzer.setup{}
      require"lspconfig".clangd.setup{}
    end,
  },
}

return M
