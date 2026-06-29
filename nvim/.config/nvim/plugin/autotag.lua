vim.pack.add({
    "https://github.com/tronikelis/ts-autotag.nvim",
})

local autotag = require("ts-autotag")
autotag.setup({
    auto_rename = {
        enabled = true,
    },
})
