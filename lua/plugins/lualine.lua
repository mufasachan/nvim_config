local M = { "nvim-lualine/lualine.nvim" }

M.dependencies = { "nvim-web-devicons" }

M.opts = {
  options = {
    globalstatus = true,
    disabled_filetypes = { "NvimTree", "dashboard" },
    section_separators = "",
    component_separators = "",
  },
  tabline = {
    lualine_a = { { "datetime", style = "%H:%M" } },
    lualine_b = { { "filetype", icon_only = true } },
    lualine_c = { { "filename", path = 1 } },
    lualine_z = { "tabs" },
  },
  sections = {
    lualine_b = { "branch", "diff" },
    lualine_c = {
      {
        function()
          local register = vim.fn.reg_recording()
          if register == "" then return "" end
          return "@" .. register
        end,
        color = { fg = "#ea9a97" }
      },
    },
    lualine_x = { "diagnostics" },
    lualine_y = { "searchcount" },
    lualine_z = { "location" },
  },
}

return M
