vim.pack.add({ "https://github.com/folke/lazy.nvim" }, {
    confirm = false,
})

local lazy = require("lazy")
lazy.setup("user.plugins", {
    dev = {
        fallback = true,
        path = "~/Projects",
        patterns = {
            "michel-garcia",
        },
    },
    install = {
        colorscheme = {
            "gruvbox-baby",
        },
    },
    ui = {
        border = "single",
    },
})
