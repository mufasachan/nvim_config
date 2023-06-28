require'plugins.lsp'

local function config_cmp()
  -- Load useful plugins
  local lspconfig = require('lspconfig')
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'

  -- Add additional capabilities supported by nvim-cmp
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  local servers = { "lua_ls", "pyright", "taplo"}
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      -- on_attach = my_custom_on_attach,
      capabilities = capabilities,
    }
  end

  cmp.setup {
    snippet = {
      expand = function(args)
	luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
      ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
      -- C-b (back) C-f (forward) for snippet placeholder navigation.
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm {
	behavior = cmp.ConfirmBehavior.Replace,
	select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
	if cmp.visible() then
	  cmp.select_next_item()
	elseif luasnip.expand_or_jumpable() then
	  luasnip.expand_or_jump()
	else
	  fallback()
	end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
	if cmp.visible() then
	  cmp.select_prev_item()
	elseif luasnip.jumpable(-1) then
	  luasnip.jump(-1)
	else
	  fallback()
	end
      end, { 'i', 's' }),
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    },
  }
end

return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {},
  },
  {
    'hrsh7th/nvim-cmp',
    -- event = "InsertEnter",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      { -- Snippets
	'saadparwaiz1/cmp_luasnip',
	dependencies = {
	  'L3MON4D3/LuaSnip',
	  "rafamadriz/friendly-snippets",
	},
	config = function ()
	  require("luasnip.loaders.from_vscode").lazy_load()
	end
      },
    },
    config = config_cmp,
  },
  {"numToStr/Comment.nvim", opts = {}}
}
