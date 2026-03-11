local M = { "folke/todo-comments.nvim" }
M.dependencies = { "plenary" }

M.opts = {
  keywords = {
    QUESTION = { icon = " ", color = "question", alt = { "QUESTION" } },
  },
  colors = {
    question = { "#95b1ac" }, -- from colorscheme:rose-pine,variant:moon,color:leaf
  }
}

M.config = function(_, opts)
  local todo = require("todo-comments")
  todo.setup(opts)
  require "which-key".add({
    { "[t", todo.jump_prev },
    { "]t", todo.jump_next },
  })
end


return M
