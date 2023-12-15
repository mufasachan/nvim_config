local plugin = {"luukvbaal/statuscol.nvim"}
plugin.name = "statuscol"

local function get_opts(builtin)
	return {
		relculright = true,
		segments = {
			{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
			{ text = { "%s" }, click = "v:lua.ScSa" },
			{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
		},
	}
end

function plugin.config()
	local builtin = require("statuscol.builtin")
	local opts = get_opts(builtin)

	require("statuscol").setup(opts)
end

return plugin
