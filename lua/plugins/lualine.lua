local M = { "nvim-lualine/lualine.nvim" }

M.dependencies = { "nvim-web-devicons" }

-- SPECIFICS COMPONENTS SETTINGS
-- path = 1 is relative path
M.opts = {
  options = {
    globalstatus = true,
    disabled_filetypes = { "NvimTree", "dashboard" },
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_b = { "branch" },
    lualine_c = {
      {
        function()
          local register = vim.fn.reg_recording()
          if register == "" then return "" end
          return "@" .. register
        end,
        color = { fg = "#ea9a97" }
      },
      { "filename", path = 1 },
    },
    lualine_x = { "searchcount", "filetype" },
    lualine_y = { { "datetime", style = "%H:%M" } },
    lualine_z = { "progress", "location" },
  },
}

return M
