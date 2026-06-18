vim.pack.add({
    "https://github.com/folke/todo-comments.nvim",
})

local todo = require("todo-comments")
todo.setup()
