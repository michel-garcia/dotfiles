vim.pack.add({
    "https://github.com/michel-garcia/radix.nvim",
})

local radix = require("radix")
radix.setup({
    patterns = {
        ".git",
        "Makefile",
        "composer.json",
        "meson.build",
        "node_modules",
        "package.json",
        "vendor",
    },
})
