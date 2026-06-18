vim.pack.add({
    "https://github.com/brenoprata10/nvim-highlight-colors",
})

local colors = require("nvim-highlight-colors")
colors.setup({
    render = "virtual",
})
