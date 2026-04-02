-- wait https://github.com/neovim/neovim/issues/33577 for better on_attach modification.
-- seems to wait 0.12 https://github.com/neovim/neovim/issues/32074
local wk = require "which-key"
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    local buf = event.buf
    if client and client.name == "basedpyright" then
      wk.add { { "gS", "<CMD>:FzfLua lsp_live_workspace_symbols<CR>", silent = true, buffer = buf } }
    end

    wk.add({
      {
        "gI",
        function()
          -- Edit the ' mark manually because vim.fn.search sets mark
          --  - Go to top and search of the import pattern
          --  - If found, go to the import name and set a mark
          --  - Go back to the original position (saved) and set a mark there
          --  - Profit of the `` or '' to back where you were
          -- Search forward from top of file for an import line with this symbol
          local word = vim.fn.expand("<cword>")
          local saved_position = vim.api.nvim_win_get_cursor(0)
          local saved_search = vim.fn.getreg("/")

          vim.api.nvim_win_set_cursor(0, { 1, 0 })
          local found = vim.fn.search([[\(import\|as\).*\<]] .. word .. [[\>]], "Ws")

          vim.fn.setreg("/", saved_search)
          vim.cmd("nohlsearch")

          -- Restore position if nothing found
          if found == 0 then
            vim.api.nvim_win_set_cursor(0, saved_position)
            vim.notify("No import found for: " .. word, vim.log.levels.WARN)
          else
            local import_position = vim.api.nvim_win_get_cursor(0)

            -- move cursor to the searched world
            local column_import = vim.api.nvim_get_current_line():find(vim.pesc(word))
            vim.api.nvim_win_set_cursor(0, saved_position)
            vim.cmd("normal! m'")
            vim.api.nvim_win_set_cursor(0, { import_position[1], column_import - 1 })
          end
        end,
        buffer = buf,
        desc = "Go to import line"
      }
    })
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
