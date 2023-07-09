local lspconfig = require('lspconfig')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path
      },
      diagnostics = { globals = {'vim'} },
      workspace = {
        library = {
          -- Make the server aware of Neovim runtime files
          vim.fn.expand('$VIMRUNTIME/lua'),
          vim.fn.stdpath('config') .. '/lua'
        },
        checkThirdParty = false
      },
      telemetry = { enable = false },
    }
  }
})

