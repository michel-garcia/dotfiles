return {
    "michel-garcia/radix.nvim",
    config = function()
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
    end,
}
