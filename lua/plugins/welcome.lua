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
				icon = "",
				desc = " Go to folder ...",
				key = "f",
				key_format = "%s",
				action = "FineCmdline cd "
			},
			{
				icon = "󰒲",
				desc = " Plugins",
				key = "p",
				key_format = "%s",
				action = "Lazy",
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

-- Copy/paste/adapted from dashboard 
-- fabf5feec96185817c732d47d363f34034212685
-- TODO: Disable illuminate and/or just the hl group for the line for the current buffer only.
-- only commit when it's done
local function disable_move_and_cursor()
	-- No move
  local keys = { 'w', 'f', 'b', 'h', 'j', 'k', 'l', '<Up>', '<Down>', '<Left>', '<Right>' }
  vim.tbl_map(function(key)
		vim.api.nvim_buf_set_keymap(0, "n", key, "<NOP>", {})
  end, keys)
end


local function savebuffers_and_opendashboard()
	-- Save current session, close everything and open dashboard
	vim.cmd("SessionManager save_current_session")

	local ids_buffers = vim.api.nvim_list_bufs()
	for i = 1, #ids_buffers do
		vim.api.nvim_buf_delete(ids_buffers[i], { force = true })
	end

	vim.cmd("Dashboard")
end

function plugin.config(_, opts)
	require("which-key").add({
		{ lhs = "<Leader>H", rhs = savebuffers_and_opendashboard, desc = "Home", silent = true }
	})

	local id_group = vim.api.nvim_create_augroup("Startup", {})

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
		callback = function() vim.defer_fn(callback, 1) end,
		group = id_group,
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern="dashboard",
		callback = disable_move_and_cursor,
		group = id_group,
	})
end

return plugin
