local M = { "benlubas/molten-nvim" }

M.build = ":UpdateRemotePlugins"
M.dependencies = { "image" }


function M.init()
  -- pynvim, jupyter_client, cairo, jupytext etc ... are installed in this venv
  vim.g.python3_host_prog = vim.fn.expand("~/.local/share/nvim/nvim-python/bin/python")

  vim.g.molten_image_provider = "image.nvim"
  vim.g.molten_output_win_max_height = 20
  vim.g.molten_virt_lines_off_by_1 = true
end

function M.config()
  local runner = require("quarto.runner")
  local wk = require("which-key")
  local function set_key()
    require("which-key").add({
      { mode = "v", lhs = "\\e",                         rhs = "<CMD>MoltenEvaluateVisual<CR>",   desc = "Visual", buffer = true },
      { "\\i",      "<CMD>MoltenInit<CR>",               desc = "Init molten",                    buffer = true },
      { "\\e",      "<CMD>MoltenEvaluateOperator<CR>",   desc = "Evaluate",                       buffer = true },
      { "\\rc",     runner.run_cell,                     desc = "run cell",                       silent = true,   buffer = true },
      { "\\ra",     runner.run_above,                    desc = "run cell and above",             silent = true,   buffer = true },
      { "\\rA",     runner.run_all,                      desc = "run all cells",                  silent = true,   buffer = true },
      { "\\rl",     runner.run_line,                     desc = "run line",                       silent = true,   buffer = true },
      { "\\rr",     runner.run_range,                    desc = "run visual range",               silent = true,   buffer = true },
      { "\\RA",     function() runner.run_all(true) end, desc = "run all cells of all languages", silent = true,   buffer = true },
      { "\\os",     ":noautocmd MoltenEnterOutput<CR>",  desc = "open output window",             silent = true, },
    })
  end

  -- Provide a command to create a blank new Python notebook
  --- @type table<number, boolean | nil>
  --- Prevent double call of imb
  local buf_to_molten_state = {}
  vim.api.nvim_create_autocmd("User",
    {
      pattern = "MoltenInitPost",
      callback = function(e)
        buf_to_molten_state[e.buf] = true
        set_key()
      end
    })
  vim.api.nvim_create_autocmd("User",
    { pattern = "MoltenDeinitPost", callback = function(e) buf_to_molten_state[e.buf] = false end })
  -- automatically import output chunks from a jupyter notebook
  -- tries to find a kernel that matches the kernel in the jupyter notebook
  -- falls back to a kernel that matches the name of the active venv (if any)
  local imb = function(e) -- init molten buffer
    vim.schedule(function()
      if buf_to_molten_state[e.buf] then
        return
      end
      local kernels = vim.fn.MoltenAvailableKernels()
      local try_kernel_name = function()
        local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
        return metadata.kernelspec.name
      end
      local ok, kernel_name = pcall(try_kernel_name)
      if not ok or not vim.tbl_contains(kernels, kernel_name) then
        kernel_name = nil
        local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
        if venv ~= nil then
          kernel_name = string.match(venv, "/.+/(.+)")
        end
      end
      if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
        vim.cmd(("MoltenInit %s"):format(kernel_name))
      end
      vim.cmd("MoltenImportOutput")
    end)
  end

  -- automatically import output chunks from a jupyter notebook
  vim.api.nvim_create_autocmd("BufAdd", {
    pattern = { "*.ipynb" },
    callback = imb,
  })

  -- we have to do this as well so that we catch files opened like `nvim ./hi.ipynb`
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.ipynb" },
    callback = function(e)
      if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
        imb(e)
      end
    end,
  })

  -- automatically export output chunks to a jupyter notebook on write
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.ipynb" },
    callback = function()
      if require("molten.status").initialized() == "Molten" then
        vim.cmd("MoltenExportOutput!")
      end
    end,
  })

  -- note: the metadata is needed for Jupytext to understand how to parse the notebook.
  -- if you use another language than Python, you should change it in the template.
  local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

  local function new_notebook(filename)
    local path = filename .. ".ipynb"
    local file = io.open(path, "w")
    if file then
      file:write(default_notebook)
      file:close()
      vim.cmd("edit " .. path)
    else
      print("Error: Could not open new notebook file for writing.")
    end
  end

  vim.api.nvim_create_user_command("NewNotebook", function(opts)
    new_notebook(opts.args)
  end, {
    nargs = 1,
    complete = "file"
  })

  wk.add({
    "<Leader>n",
    function()
      vim.api.nvim_feedkeys(":NewNotebook ", "n", false)
    end,
    desc = "New notebook"
  })
end

return M
