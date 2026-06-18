vim.pack.add({
    "https://github.com/lukas-reineke/indent-blankline.nvim",
})

local indent = require("ibl")
indent.setup({
    scope = {
        show_end = false,
        show_start = false,
    },
})
