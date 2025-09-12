-- Set hidden files but not .git in vimgrep
-- local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }
-- table.insert(vimgrep_arguments, "--hidden")
-- table.insert(vimgrep_arguments, "--glob")
-- table.insert(vimgrep_arguments, "!**/.git/*")
-- plugin.opts.defaults.vimgrep_arguments = vimgrep_arguments
local M = { "nvim-telescope/telescope.nvim" }
M.name = "telescope"

M.dependencies = {
  "nvim-web-devicons",
  "trouble",
  "plenary",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "mufasachan/telescope-cdfolder" },
  -- { dir = "~/code/telescope-cdfolder.nvim/" },
}

M.opts = {
  defaults = {
    mappings = {
      n = { ["q"] = "close" },
      i = {
        ["kj"] = "close",
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { "fd", "-H", "-I", "-E", ".mypy_cache", "-E", ".venv", "-E", ".git", "--type", "f" },
    }
  },
  extensions = {
    cdfolder = {
      cwd_to_exclude_dir = {
        ["*"] = {
          "node_modules",
          "venv",
          ".git",
        },
        -- slow laptop
        ["home"] = {
          ".cache",
          ".cargo",
          ".local/share/containers",
          ".local/share/pnpm",
          ".local/share/virtualenv",
          ".mozilla",
          ".npm",
          ".rustup",
        },
      }
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true
    }
  }
}

function M.config(_, opts)
  local wk = require "which-key"

  local open_with_trouble = function(bufnr)
    ---@diagnostic disable-next-line: missing-fields
    return require("trouble.sources.telescope").open(bufnr, {
      focus = true,
    })
  end
  opts.pickers["live_grep"] = {
    mappings = {
      i = { ["<C-t>"] = open_with_trouble },
      n = { ["<C-t>"] = open_with_trouble },
    }
  }

  local telescope = require "telescope"
  telescope.setup(opts)
  telescope.load_extension("fzf")
  telescope.load_extension("cdfolder")
end

return M
