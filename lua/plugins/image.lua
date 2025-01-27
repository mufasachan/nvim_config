local M = { "3rd/image.nvim" }
M.name = "image"
M.opts = {
	integrations = {
		neorg = {
      enabled = true,
      filetypes = { "norg" },
    },
	}
}
return M
