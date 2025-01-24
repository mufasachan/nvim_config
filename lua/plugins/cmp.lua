local plugin = { "hrsh7th/nvim-cmp" }

plugin.dependencies = {
	-- Sources
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "saadparwaiz1/cmp_luasnip" },

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		-- Replace <CurrentMajor> by the latest released major (first number of latest release)
		version = "v2.*",
		-- install jsregexp (optional!).
		build = "make install_jsregexp"
	},
	{ "rafamadriz/friendly-snippets" },
}

function plugin.opts(_, opts)
	opts.sources = {
		-- Special source for lua/nvim dev
		{ name = "lazydev", group_index = 0 },
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer",  keyword_length = 3 },
	}
	opts.formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				luasnip = "⋗",
				buffer = "Ω",
				path = "🖫",
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	}

	local luasnip = require("luasnip")
	opts.snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	}

	local cmp = require("cmp")
	opts.window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	}

	local select_opts = { behavior = cmp.SelectBehavior.Select }
	opts.mapping = {
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),

		["<C-e>"] = cmp.mapping.abort(),
		["<C-x>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),

		-- Snippet navigation in placeholders
		["<C-f>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-b>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		-- Useful tab in cmp menu
		["<Tab>"] = cmp.mapping(function(fallback)
			local col = vim.fn.col(".") - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				fallback()
			else
				cmp.complete()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
	}
end

function plugin.config(_, opts)
	vim.opt.completeopt = { "menu", "menuone", "noselect" }

	-- lazy_load change the time the snippets are loaded, namely when BufEnter I guess
	-- For some setup, tex ftplugin for instance, it's better if it's loaded normally.
	require("luasnip.loaders.from_vscode").load()


	require("cmp").setup(opts)
end

return plugin
