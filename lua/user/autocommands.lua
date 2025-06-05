local wk = require "which-key"

-- -1: no windown
-- in other value: win_peeker ID
local win_peeker = -1
local function peek_definition()
  if win_peeker ~= -1 then
    vim.api.nvim_set_current_win(win_peeker)
    return
  end

  local win = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_get_current_buf()
  local uri = vim.uri_from_bufnr(bufnr)
  local client = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/definition" })[1]
  local params = vim.lsp.util.make_position_params(win, client.offset_encoding)

  local function callback(err, results, _)
    if not results or err then return end

    local result_definition = nil
    for _, result in ipairs(results) do
      local uri_def = result["targetUri"] or result["uri"]
      if uri_def == uri then
        -- no action if more than one def in a single file
        if result_definition then
          return
        end
        result_definition = result
      end
    end
    if not result_definition then return end

    local range = result_definition["targetRange"] or result_definition["range"]
    local width = 8 * (range["end"]["character"] - range["start"]["character"])
    local height = range["end"]["line"] - range["start"]["line"] + 1
    --- @type vim.api.keyset.win_config
    local win_opts = {
      relative = "cursor",
      width = width,
      height = height,
      row = -height - 2,
      col = 0,
      border = "rounded",
      style = "minimal"
    }


    -- I failed to remove the indentblank-line text for the windown only. Since virtual text is a buffer-level thing and that my namespace inherit from all other namespace, then I get the virtual text ...
    local ns_peeker = vim.api.nvim_create_namespace("peeker")
    vim.api.nvim_set_hl(ns_peeker, "IlluminatedWordText", {})
    vim.api.nvim_set_hl(ns_peeker, "IlluminatedWordRead", {})
    vim.api.nvim_set_hl(ns_peeker, "IlluminatedWordWrite", {})
    vim.api.nvim_set_hl(ns_peeker, "@ibl.scope.underline.1", {})

    win_peeker = vim.api.nvim_open_win(bufnr, false, win_opts)
    vim.api.nvim_win_set_hl_ns(win_peeker, ns_peeker)

    local cursor_position_init = vim.api.nvim_win_get_cursor(win)

    vim.api.nvim_set_option_value("statuscolumn", " ", { win = win_peeker })
    vim.api.nvim_set_option_value("wrap", false, { win = win_peeker })

    vim.api.nvim_win_set_cursor(
      win_peeker,
      { range["start"]["line"] + 1, range["start"]["character"] }
    )

    local group_peeker = vim.api.nvim_create_augroup("peeker", { clear = true })
    -- I do not understand why when the window is closed by CursodMoved, there is no Event WinClosed event
    -- Thus, I need to create a function to close the windown and clean the autocommand group and the special mapping for the window.
    local function close_window_peeker_and_clean()
      vim.api.nvim_win_close(win_peeker, false)
      win_peeker = -1
      vim.api.nvim_del_augroup_by_id(group_peeker)
      vim.api.nvim_del_keymap("n", "q")
    end
    local function create_autocommand_cursor_move_close_float()
      return vim.api.nvim_create_autocmd("CursorMoved", {
        group = group_peeker,
        buffer = bufnr,
        callback = function()
          local win_current = vim.api.nvim_get_current_win()
          if win_current == win then
            local cursor_position_new = vim.api.nvim_win_get_cursor(win_current)
            if cursor_position_new[1] ~= cursor_position_init[1] or cursor_position_new[2] ~= cursor_position_init[2] then
              close_window_peeker_and_clean()
            end
          end
        end
      })
    end
    wk.add {
      { "<Enter>", function()
        if vim.api.nvim_get_current_win() == win then
          vim.api.nvim_set_current_win(win_peeker)
        end
      end },
      { "q", function()
        if vim.api.nvim_get_current_win() == win_peeker then
          vim.api.nvim_win_close(win_peeker, false)
        end
      end }
    }
    local cursormoved_autocommand = create_autocommand_cursor_move_close_float()
    vim.api.nvim_create_autocmd("WinEnter", {
      group = group_peeker,
      callback = function()
        if vim.api.nvim_get_current_win() == win_peeker then
          vim.api.nvim_del_autocmd(cursormoved_autocommand)
        end
      end
    })
    vim.api.nvim_create_autocmd("WinLeave", {
      group = group_peeker,
      callback = function()
        if vim.api.nvim_get_current_win() == win_peeker then
          cursormoved_autocommand = create_autocommand_cursor_move_close_float()
        end
      end
    })
    vim.api.nvim_create_autocmd("WinClosed", {
      group = group_peeker,
      callback = function()
        close_window_peeker_and_clean()
      end
    })
  end

  client:request("textDocument/definition", params, callback, bufnr)
end

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP keymaps",
  callback = function(event)
    wk.add({
      { "<Enter>", peek_definition,                         buffer = event.buf },
      { "gd",      "<CMD>Trouble lsp_definitions<CR>",      buffer = event.buf },
      { "gD",      vim.lsp.buf.declaration,                 buffer = event.buf },
      { "gt",      "<CMD>Trouble lsp_type_definitions<CR>", buffer = event.buf },
    })
  end
})

vim.api.nvim_create_autocmd("BufWrite", {
  callback = function()
    if vim.lsp.get_clients({ bufnr = 0, method = "textDocument/formatting" }) then
      vim.lsp.buf.format()
    end
  end
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

local startup_group = vim.api.nvim_create_augroup("Startup", {})
local argv = vim.fn.argv()

-- No args -> dashboard should be displayed.
if #argv == 0 then
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.cmd("Dashboard")
    end,
    group = startup_group,
  })
else
  local stat = vim.uv.fs_stat(argv[1])
  if stat and stat.type == "directory" then
    vim.cmd.cd(argv[1])
    vim.cmd.SessionManager("load_current_dir_session")
  end
end
