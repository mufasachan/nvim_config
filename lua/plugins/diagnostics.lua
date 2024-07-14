local plugin = { "folke/trouble.nvim" }

plugin.dependencies = { { "nvim-web-devicons" }, { "which-key" } }

function plugin.config()
	-- Choose shape of diagnostic icons
	local function sign(opts)
		vim.fn.sign_define(opts.name, {
			texthl = opts.name,
			text = opts.text,
			numhl = "",
		})
	end
	sign({ name = "DiagnosticSignError", text = "✘" })
	sign({ name = "DiagnosticSignWarn", text = "▲" })
	sign({ name = "DiagnosticSignHint", text = "⚑" })
	sign({ name = "DiagnosticSignInfo", text = "»" })

	-- Neovim config of diagnostic
	vim.diagnostic.config({
		virtual_text = false,
		severity_sort = true,
		float = {
			border = "rounded",
			source = "always",
		},
	})

	-- Keymappings for diagnostic
	local wk = require "which-key"
	wk.register({
		["<Leader>d"] = { name = "Diagnostic" },
	})
	local map = vim.keymap.set
	map("n", "<leader>di", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Info" })
	map("n", "<Leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Next" })
	map("n", "<Leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Previous" })
	map("n", "<Leader>dw", ":TroubleToggle<CR>", { desc = "Workspace" })
	map("n", "<Leader>dd", ":TroubleToggle document_diagnostics<CR>", { desc = "Document" })
end

return plugin
