local plugin = { "folke/which-key.nvim" }
plugin.name = "which-key"

plugin.dependencies = { "nvim-web-devicons" }

plugin.init = function()
	vim.o.timeout = true
	vim.o.timeoutlen = 500

	local wk = require "which-key"
	wk.add({
		{ "<Leader>b", group = "Buffer" },
		{ "<Leader>f", group = "Finder" },
	})
end

---Disable unwanted triggers
---@param ctx {keys: string, mode: string, plugin?: string}
---@return boolean
local function disable_triggers(ctx)
	return (ctx.mode ~= "n") or (string.len(ctx.keys) ~= 7) or (ctx.keys:sub(1, 7) ~= "<Space>")
end
plugin.opts = {
	preset = "modern",
	delay = 200,
	disable = { trigger = disable_triggers },
	icons = { rules = false },
}

plugin.event = "VeryLazy"

return plugin
