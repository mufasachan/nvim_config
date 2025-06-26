local M = { "saghen/blink.cmp" }
M.dependencies = { "rcarriga/cmp-dap" }

-- use a release tag to download pre-built binaries
M.version = "1.*"

-- source https://www.reddit.com/r/neovim/comments/1hneftb/get_completions_in_daprepl_buffer_with_blinkcmp/?show=original
-- thanks
local function is_dap_buffer()
  return require("cmp_dap").is_dap_buffer()
end


---@module 'blink.cmp'
---@type blink.cmp.Config
M.opts = {
  enabled = function()
    return vim.bo.buftype ~= "prompt" or is_dap_buffer()
  end,
  -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  -- 'super-tab' for mappings similar to vscode (tab to accept)
  -- 'enter' for enter to accept
  -- 'none' for no mappings
  -- All presets have the following mappings :h blink-cmp-config-keymap
  -- C-space: Open menu or open docs if already open
  -- C-n/C-p or Up/Down: Select next/previous item
  -- C-e: Hide menu
  -- C-k: Toggle signature help (if signature.enabled = true)
  keymap = {
    preset = "enter",
    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    ["<C-n>"] = { "snippet_forward", "fallback_to_mappings" },
    ["<C-p>"] = { "snippet_backward", "fallback_to_mappings" },
    ["<Tab>"] = { "select_next", "fallback_to_mappings" },
    ["<S-Tab>"] = { "select_prev", "fallback_to_mappings" },
  },

  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = "mono"
  },

  -- (Default) Only show the documentation popup when manually triggered
  completion = {
    documentation = { auto_show = false },
  },

  snippets = {
    preset = "luasnip"
  },

  sources = {
    default = function()
      if is_dap_buffer() then
        return { "dap", "snippets", "buffer" }
      end
      return { "lsp", "path", "snippets", "dap", "buffer" }
    end,
    providers = {
      dap = { name = "dap", module = "blink.compat.source" },
    },
  },
  signature = { enabled = true },
  -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
  -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
  -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
  --
  -- See the fuzzy documentation for more information
  fuzzy = { implementation = "prefer_rust_with_warning" },
}
M.opts_extend = { "sources.default" }

local M_blink_compat = { "saghen/blink.compat", version = "2.*", lazy = true, opts = {} }
return { M, M_blink_compat }
