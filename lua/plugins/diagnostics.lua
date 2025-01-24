-- Trouble manages diagnostics.
-- I love this plugin very much so I search LSP info (symbols, def, ref ...)
local plugin = { "folke/trouble.nvim" }
plugin.name = "trouble"

plugin.dependencies = { { "nvim-web-devicons" }, { "which-key" } }

--- Utils to map with a rhs which is a lua callback
---@param mode string
---@param lhs string
---@param rhs_lua function
---@param desc string
local function maplua(mode, lhs, rhs_lua, desc)
	-- 0 is current buffer
	vim.api.nvim_buf_set_keymap(0, mode, lhs, "<Nop>",
		{ desc = desc, callback = rhs_lua })
end

--- To be called when Trouble is useful, i.e. LspAttach
local function set_lspkeymaps()
	-- Keymappings for diagnostic
	local trouble = require "trouble"
	local wk = require "which-key"
	wk.add({
		{ lhs = "<Leader>d",  group = "Diagnostics" },
		{ lhs = "<Leader>t",  group = "Trouble" },
		{ lhs = "<Leader>dq", rhs = "<CMD>Trouble qflist focus=1<CR>", desc = "qflist" },
	})

	--- Utils command for mapping action on Trouble's modes
	--- @param mode string Vim mode
	--- @param lhs string
	--- @param modetrouble string
	--- @param desc string
	local function mapmode(mode, lhs, modetrouble, desc)
		local rhs_lua = function()
			trouble.toggle(modetrouble)
		end
		maplua(mode, lhs, rhs_lua, desc)
	end
	-- Toggle trouble modes
	mapmode("n", "<leader>dd", "diagnostics", "Diagnostics")
	mapmode("n", "<leader>ts", "my_symbols", "Symbols")
	mapmode("n", "<leader>td", "lsp_definitions", "Definition")
	mapmode("n", "<leader>tr", "lsp_references", "Definition")
	mapmode("n", "<leader>tT", "lsp_type_definitions", "Definition")
	mapmode("n", "<leader>ta", "my_lsp", "Show all")
	maplua("n", "<leader>tt", trouble.focus, "Focus")
	maplua("n", "<leader>tc", trouble.close, "Close")
	-- Navigation
	maplua("n", "<leader>dn", vim.diagnostic.goto_next, "Next")
	maplua("n", "<leader>ds", vim.diagnostic.open_float, "Show (current)")
	maplua("n", "<leader>dp", vim.diagnostic.goto_prev, "Previous")
end

plugin.opts = {
	keys = {
		["?"] = "help",
		R = "toggle_refresh",
		q = "close",
		o = "jump_close",
		["<cr>"] = "jump",
		["<c-s>"] = "jump_split",
		["<c-v>"] = "jump_vsplit",
		["}"] = "next",
		["]]"] = "next",
		["{"] = "prev",
		["[["] = "prev",
		dd = "delete",
		d = { action = "delete", mode = "v" },
		i = "inspect",
		p = "preview",
		P = "toggle_preview",
		H = "fold_toggle",
		zM = "fold_close_all",
		zR = "fold_close_all",
		tf = {
			action = function(view)
				view:filter({ kind = "Function" }, {
					id = "function",
					template = "{hl:Title}Functions{hl} only",
					toggle = true
				})
			end,
			desc = "Toggle Functions",
		},
		to = {
			action = function(view)
				view:filter({ any = { { kind = "Object" }, { kind = "Variable" } } }, {
					id = "function",
					template = "{hl:Title}Objects{hl} and {hl:Title}variables{hl} only",
					toggle = true
				})
			end,
			desc = "Toggle Variable/Object",
		},
		gb = { -- example of a custom action that toggles the active view filter
			action = function(view)
				view:filter({ buf = 0 }, { toggle = true })
			end,
			desc = "Toggle Current Buffer Filter",
		},
		s = { -- example of a custom action that toggles the severity
			action = function(view)
				local f = view:get_filter("severity")
				local severity = ((f and f.filter.severity or 0) + 1) % 5
				view:filter({ severity = severity }, {
					id = "severity",
					template = "{hl:Title}Filter:{hl} {severity}",
					del = severity == 0,
				})
			end,
			desc = "Toggle Severity Filter",
		},
	},
	modes = {
		lsp_definitions = { focus = true, auto_close = true },
		lsp_references = { focus = true },
		my_lsp = {
			auto_close = true,
			focus = true,
			desc = "See all info",
			mode = "lsp",
			win = {
				type = "float",
				relative = "editor",
				border = "rounded",
				zindex = 200, -- it might disappear if not set
				position = { .895, .17 },
				size = { width = .67, height = .20 },
			},
			format = "{kind_icon} {symbol.name}",
		},
		my_symbols = {
			desc = "My document LSP symbols",
			mode = "lsp_document_symbols",
			focus = true,
			win = {
				type = "float",
				relative = "editor",
				border = "rounded",
				zindex = 200, -- it might disappear if not set
				position = { .5, .995 },
				size = { width = .25, height = .80 },
			},
			format = "{kind_icon} {symbol.name}",
			filter = {
				-- remove Package since luals uses it for control flow structures
				["not"] = { ft = "lua", kind = "Package" },
				any = {
					-- all symbol kinds for help / markdown files
					ft = { "help", "markdown" },
					-- default set of symbol kinds
					kind = {
						"Class",
						"Constructor",
						"Enum",
						"Field",
						"Function",
						"Interface",
						"Method",
						"Module",
						"Namespace",
						"Object",
						"Package",
						"Property",
						"Struct",
						"Trait",
						"TypeDefiniton",
					},
				},
			},
		},
	}
}

function plugin.config(_, opts)
	-- Choose shape of diagnostic icons
	local function set_sign(_opts)
		vim.fn.sign_define(_opts.name, {
			texthl = _opts.name,
			text = _opts.text,
			numhl = "",
		})
	end
	set_sign({ name = "DiagnosticSignError", text = "" })
	set_sign({ name = "DiagnosticSignWarn", text = "" })
	set_sign({ name = "DiagnosticSignHint", text = "" })
	set_sign({ name = "DiagnosticSignInfo", text = "" })

	-- Neovim config of diagnostic
	vim.diagnostic.config({
		virtual_text = false,
		severity_sort = true,
		float = {
			border = "rounded",
			source = true,
		},
	})

	vim.api.nvim_create_autocmd({ "LspAttach" }, { callback = set_lspkeymaps })

	require "trouble".setup(opts)
end

return plugin
