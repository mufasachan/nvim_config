-- wait https://github.com/neovim/neovim/issues/33577 for better on_attach modification.
-- seems to wait 0.12 https://github.com/neovim/neovim/issues/32074
local wk = require "which-key"
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.name == "basedpyright" then
      wk.add { { "gS", "<CMD>:Telescope lsp_dynamic_workspace_symbols<CR>", silent = true, buffer = event.buf } }
    end
  end
})
return {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
      }
    }
  }
}
