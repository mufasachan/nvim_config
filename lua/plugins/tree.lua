local plugin = { "nvim-tree/nvim-tree.lua" }
plugin.name = "nvim-tree"
plugin.dependencies = { "nvim-web-devicons", "which-key" }

local function on_attach_tree(bufnr)
	-- Set nvim-tree maps
	local api = require "nvim-tree.api"
	api.config.mappings.default_on_attach(bufnr)

	local del = function(lhs) vim.keymap.del("n", lhs, { buffer = bufnr }) end
	del("<2-LeftMouse>")
	del("<2-RightMouse>")
	del("y")
	del("<")
	del(">")
	del("W")
	del("<C-R>")
	del("<BS>")
	del("e")
	del("r")
	del("<Tab>")

	local map = function(lhs, rhslua, desc)
		vim.keymap.set("n", lhs, rhslua, {
			desc = "nvim-tree: " .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true
		})
	end
	map("l", api.node.open.edit, "Open")
	map("e", api.node.open.edit, "Open")
	map("rr", api.fs.rename, "Rename")
	map("y", api.fs.copy.node, "Copy file")
	map("re", api.fs.rename_basename, "Rename basename")
	map("ro", api.fs.rename_sub, "Rename omit filename")
end

plugin.opts = {
	filters = { dotfiles = true },
	on_attach = on_attach_tree,
	renderer = { group_empty = true },
	view = { side = 'right', width = 30 },
	sync_root_with_cwd = true,
	disable_netrw = true, -- netrw-noload
	hijack_directories = { enable = false }, -- for auto-sessions
}

function plugin.config(_, opts)
	local api = require("nvim-tree.api")
	require("which-key").add({
		{ "<Leader>e", api.tree.toggle, desc = "Explorer", silent = true },
	})

	require("nvim-tree").setup(opts)
end

return plugin
