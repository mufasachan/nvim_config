local M  = { "nvim-treesitter/nvim-treesitter-textobjects" }
M.branch = "main"

M.init   = function()
  vim.g.no_plugin_maps = true
end

M.opts   = {
  move = { set_jumps = true },
  select = { lookahead = true },
}

M.config = function(_, opts)
  local textobject = require("nvim-treesitter-textobjects")
  local select = require("nvim-treesitter-textobjects.select").select_textobject
  local swap = require("nvim-treesitter-textobjects.swap")
  local move = require("nvim-treesitter-textobjects.move")
  local repeatable_move = require("nvim-treesitter-textobjects.repeatable_move")
  local f = function(fun, arg1, arg2) -- factory function with two args
    return function()
      fun(arg1, arg2)
    end
  end
  require "which-key".add {
    { mode = { "x", "o" }, lhs = "if", rhs = f(select, "@function.inner", "textobjects") },
    { mode = { "x", "o" }, lhs = "af", rhs = f(select, "@function.outer", "textobjects") },
    { mode = { "x", "o" }, lhs = "ic", rhs = f(select, "@class.inner", "textobjects") },
    { mode = { "x", "o" }, lhs = "ac", rhs = f(select, "@class.outer", "textobjects") },
    { mode = { "x", "o" }, lhs = "ii", rhs = f(select, "@conditional.inner", "textobjects") },
    { mode = { "x", "o" }, lhs = "ai", rhs = f(select, "@conditional.outer", "textobjects") },
    { mode = "n", lhs = "<Leader>s", rhs = function()
      swap.swap_next(
        "@parameter.inner")
    end, desc = "Swap next parameter" },
    { mode = "n", lhs = "<Leader>S", rhs = function()
      swap
          .swap_previous("@parameter.inner")
    end, desc = "Swap next parameter" },
    { mode = { "n", "x", "o" }, lhs = ";",  rhs = repeatable_move.repeat_last_move_next },
    { mode = { "n", "x", "o" }, lhs = ",",  rhs = repeatable_move.repeat_last_move_previous },
    { mode = { "n", "x", "o" }, lhs = "f",  rhs = repeatable_move.builtin_f_expr,                                expr = true },
    { mode = { "n", "x", "o" }, lhs = "F",  rhs = repeatable_move.builtin_F_expr,                                expr = true },
    { mode = { "n", "x", "o" }, lhs = "t",  rhs = repeatable_move.builtin_t_expr,                                expr = true },
    { mode = { "n", "x", "o" }, lhs = "T",  rhs = repeatable_move.builtin_T_expr,                                expr = true },
    -- notebook cell
    { mode = { "n", "x", "o" }, lhs = "]b", rhs = f(move.goto_next_start, "@code_cell.inner", "textobjects") },
    { mode = { "n", "x", "o" }, lhs = "[b", rhs = f(move.goto_previous_start, "@code_cell.inner", "textobjects") },
    { mode = { "n", "x", "o" }, lhs = "]B", rhs = f(move.goto_next_end, "@code_cell.inner", "textobjects") },
    { mode = { "n", "x", "o" }, lhs = "[B", rhs = f(move.goto_previous_end, "@code_cell.inner", "textobjects") },
    -- class
    { mode = { "n", "x", "o" }, lhs = "]c", rhs = f(move.goto_next_start, "@class.outer", "textobjects") },
    { mode = { "n", "x", "o" }, lhs = "[c", rhs = f(move.goto_previous_start, "@class.outer", "textobjects") },
    { mode = { "n", "x", "o" }, lhs = "]C", rhs = f(move.goto_next_end, "@class.outer", "textobjects") },
    { mode = { "n", "x", "o" }, lhs = "[C", rhs = f(move.goto_previous_end, "@class.outer", "textobjects") },
    -- function
    { mode = { "n", "x", "o" }, lhs = "]f", rhs = f(move.goto_next_start, "@function.outer", "textobjects") },
    { mode = { "n", "x", "o" }, lhs = "[f", rhs = f(move.goto_previous_start, "@function.outer", "textobjects") },
    { mode = { "n", "x", "o" }, lhs = "]F", rhs = f(move.goto_next_end, "@function.outer", "textobjects") },
    { mode = { "n", "x", "o" }, lhs = "[F", rhs = f(move.goto_previous_end, "@function.outer", "textobjects") },
  }

  textobject.setup(opts)
end

return M
