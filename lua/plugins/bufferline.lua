local M = { "akinsho/bufferline.nvim" }
M.name = "bufferline"
M.version = "*"

M.depencies = {
  { "nvim-web-devicons" },
}

M.event = "VeryLazy"

M.opts = {
  options = {
    mod = "buffers",
    themable = true,
    numbers = "none",
    close_command = "bdelete! %d",
    buffer_close_icon = "󰅖",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true,  -- whether or not tab names should be truncated
    tab_size = 10,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "(" .. count .. ")"
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "Explorer",
        text_align = "left",
        separator = true,
      }
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    get_element_icon = function(element)
      local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
      return icon, hl
    end,
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = false,
    show_tab_indicators = true,
    -- whether to show duplicate buffer prefix
    show_duplicate_prefix = false,
    -- whether or not custom sorted buffers should persist
    persist_buffer_sort = true,
    move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thin",
    always_show_bufferline = false,
    hover = {
      enabled = false,
      delay = 200,
      reveal = { "close" }
    },
    sort_by = "insert_after_current"
  },
  highlights = {
    buffer = {
      italic = false
    },
    buffer_selected = {
      italic = false
    },
    indicator_selected = {
      fg = { attribute = "fg", highlight = "Function" },
      italic = false
    },
    diagnostic_selected = { italic = false, },
    numbers_selected = { italic = false, },
    hint_selected = { italic = false, },
    hint_diagnostic_selected = { italic = false, },
    info_selected = { italic = false, },
    info_diagnostic_selected = { italic = false, },
    warning_selected = { italic = false, },
    warning_diagnostic_selected = { italic = false, },
    error_selected = { italic = false, },
    error_diagnostic_selected = { italic = false, },
  }
}

function M.config(_, opts)
  require "bufferline".setup(opts)
  local wk = require("which-key")
  wk.add({
    { "<Leader>b",  group = "Buffer" },
    { "<Tab>",      "<CMD>BufferLineCycleNext<CR>",    desc = "Next buffer",          hidden = true },
    { "<S-Tab>",    "<CMD>BufferLineCyclePrev<CR>",    desc = "Previous buffer",      hidden = true },
    { "<Leader>c",  "<cmd>bp|bd #<cr>",                desc = "Close buffer",         silent = true,  hidden = true },
    { "<Leader>C",  "<cmd>bp|bd! #<cr>",               desc = "Close buffer (Force)", silent = true,  hidden = true },
    { "<leader>bb", "<cmd>e #<cr>",                    desc = "Back",                 silent = true },
    { "<Leader>b>", "<CMD>BufferLineMoveNext<CR>",     desc = "Move next" },
    { "<Leader>b<", "<CMD>BufferLineMovePrev<CR>",     desc = "Move previous" },
    { "<Leader>bc", "<CMD>BufferLineCloseOthers<CR>",  desc = "Close others" },
    { "<Leader>bp", "<CMD>BufferLineTogglePin<CR>",    desc = "Toggle Pin" },
    -- Dvorak go to first buffer
    { "<Leader>ba", "<CMD>BufferLineGoToBuffer 1<CR>", desc = "Goto buffer 1" },
    { "<Leader>bo", "<CMD>BufferLineGoToBuffer 2<CR>", desc = "Goto buffer 2" },
    { "<Leader>be", "<CMD>BufferLineGoToBuffer 3<CR>", desc = "Goto buffer 3" },
    { "<Leader>bu", "<CMD>BufferLineGoToBuffer 4<CR>", desc = "Goto buffer 4" },
    { "<Leader>bi", "<CMD>BufferLineGoToBuffer 5<CR>", desc = "Goto buffer 5" },
    { "gp",         "<CMD>BufferLinePick<CR>",         desc = "Buffers" },
  })
end

function M.init()

end

return M
