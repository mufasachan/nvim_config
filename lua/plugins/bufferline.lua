local plugin = {'akinsho/bufferline.nvim'}
plugin.name = 'bufferline'
plugin.version = "*"

plugin.event = 'VeryLazy'

plugin.opts = {
	options = {
		mod = "buffers",
		themable = true,
		numbers = "none",
		close_command = "bdelete! %d",
		buffer_close_icon = '󰅖',
		modified_icon = '●',
		close_icon = '',
		left_trunc_marker = '',
		right_trunc_marker = '',
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		truncate_names = true, -- whether or not tab names should be truncated
		tab_size = 10,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return "("..count..")"
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
			local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
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
			reveal = {'close'}
		},
		sort_by = 'insert_after_current'
	},
	highlights = {
		buffer = {
			italic = false
		},
		buffer_selected = {
			italic = false
		},
		indicator_selected = {
			fg = {attribute = 'fg', highlight = 'Function'},
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

function plugin.init ()
	local map = vim.keymap.set
	-- from Lazy keymaps
	-- Cycle buffer with bufferline
	map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")
	map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>")
	map("n", "[b", "<cmd>BufferLineCyclePrev<cr>")
	map("n", "]b", "<cmd>BufferLineCycleNext<cr>")
end


return plugin

