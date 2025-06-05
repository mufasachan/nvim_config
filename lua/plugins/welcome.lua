local plugin = { "nvimdev/dashboard-nvim" }
plugin.dependencies = { "nvim-tree/nvim-web-devicons", "which-key" }

local function goto_settings()
  vim.cmd.cd("~/.config/nvim")
  vim.cmd("SessionManager load_current_dir_session")
end

local function create_banner()
  local header = {
    [[                                                                                                   ]],
    [[███╗   ███╗███████╗███╗   ███╗███████╗███╗   ██╗████████╗ ██████╗                                  ]],
    [[████╗ ████║██╔════╝████╗ ████║██╔════╝████╗  ██║╚══██╔══╝██╔═══██                                  ]],
    [[██╔████╔██║█████╗  ██╔████╔██║█████╗  ██╔██╗ ██║   ██║   ██║   ██                                  ]],
    [[██║╚██╔╝██║██╔══╝  ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   ██║   ██   ███╗   ███╗ ██████╗ ██████╗ ██╗]],
    [[██║ ╚═╝ ██║███████╗██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   ╚██████╔   ████╗ ████║██╔═══██╗██╔══██╗██║]],
    [[╚═╝     ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝   ██╔████╔██║██║   ██║██████╔╝██║]],
    [[                                                                    ██║╚██╔╝██║██║   ██║██╔══██╗██║]],
    [[            "Droit ou redressé" --- Marcus Aurelius                 ██║ ╚═╝ ██║╚██████╔╝██║  ██║██║]],
    [[                                                                    ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝]],
  }
  local center = {
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
      desc = " Open folders ...",
      key = "f",
      key_format = "%s",
      action = "Telescope cdfolder find"
    },
    {
      icon = "",
      desc = " Draft",
      key = "d",
      key_format = "%s",
      action = ":enew",
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
  }
  local footer = {}
  local blank_line = [[                                             ]]

  local n_lines_content = #header + (#center * 2)
  local bonus_lines = vim.o.lines - n_lines_content
  if bonus_lines > 0 then
    local bonus_lines_footer = math.floor(bonus_lines / 2)
    for _ = 1, bonus_lines_footer do
      table.insert(header, blank_line)
    end

    local bonus_lines_header = math.ceil(bonus_lines / 2)
    if bonus_lines_header ~= bonus_lines_footer then
      table.insert(header, blank_line)
    end
  end

  local banner = { header = header, footer = footer, center = center }
  return banner
end

plugin.opts = {
  theme = "doom",
  config = create_banner()
}


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
  require("dashboard").setup(opts)

  require("which-key").add({
    { lhs = "<Leader>H", rhs = savebuffers_and_opendashboard, desc = "Home", silent = true }
  })
end

return plugin
