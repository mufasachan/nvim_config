local plugin = { "nvimdev/dashboard-nvim" }
plugin.dependencies = { "nvim-tree/nvim-web-devicons", "which-key" }

local function goto_settings()
	vim.cmd.cd("~/.config/nvim")
	vim.cmd("SessionManager load_current_dir_session")
end

plugin.opts = {
	theme = "doom",
	config = {
		header = {
			[[                                             ]],
			[[                                             ]],
			[[      __ __                        __        ]],
			[[     / //_/__ ___ ___    _______ _/ /_ _     ]],
			[[    / ,< / -_) -_) _ \  / __/ _ `/ /  ' \    ]],
			[[   /_/|_|\__/\__/ .__/  \__/\_,_/_/_/_/_/    ]],
			[[               /_/     / __/___              ]],
			[[                       > _/_ _/              ]],
			[[      _______ __________\ ___/___  ___       ]],
			[[     / __/ _ `/ __/ __/ // / / _ \/ _ \      ]],
			[[     \__/\_,_/_/ /_/  \_, /  \___/_//_/      ]],
			[[                     /___/                   ]],
			[[                                             ]],
			[[                                             ]],
			[[                                             ]],
			[[                                             ]],
		},
		center = {
			{
				icon = "󰑙",
				desc = " Restore last project",
				key = "r",
				key_format = "%s",
				action = "SessionManager load_last_session"
			},
			{
				icon = "󰆍",
				desc = " Go to projects",
				key = "g",
				key_format = "%s",
				action = "SessionManager load_session"
			},
			{
				icon = "",
				desc = " Settings",
				key = ",",
				key_format = "%s",
				action = goto_settings,
			},
			{
				icon = "",
				desc = " Close",
				key = "c",
				key_format = "%s",
				action = "quit",
			},
		},
		footer = {
			[[                                       ]],
			[[                                       ]],
			[[                                       ]],
			[["Droit ou redressé" --- Marcus Aurelius]],
		}
	}
}

function plugin.config(_, opts)
	require("which-key").add({
		{ lhs = "<Leader>H", rhs = "<CMD>Dashboard<CR>", desc = "Home ...", silent = true }
	})


	local callback = function(_)
		-- Dashboard is used when no argument
		local argv = vim.fn.argv()
		if #argv == 0 then
			require("dashboard").setup(opts)
			return
		end

		-- Sessios is used if arg is one directory
		local first_path = vim.uv.fs_realpath(argv[1])
		if #argv == 1 and vim.fn.isdirectory(first_path) == 1 then
			vim.cmd.cd(first_path)
			vim.cmd.SessionManager("load_current_dir_session")
		end
	end
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function() vim.defer_fn(callback, 1) end
	})
end

return plugin
