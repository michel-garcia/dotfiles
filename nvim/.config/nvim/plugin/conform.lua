vim.pack.add({
    "https://github.com/stevearc/conform.nvim",
})

local conform = require("conform")
conform.setup({
    formatters = {
        pasfmt = {
            args = {
                "-C",
                "tab_width=4",
                "$FILENAME",
            },
            cmd = {
                "pasfmt",
            },
            stdin = false,
        },
        prettier = {
            prepend_args = {
                "--tab-width",
                4,
            },
        },
        stylua = {
            prepend_args = {
                "--indent-type",
                "Spaces",
                "--indent-width",
                4,
            },
        },
    },
    formatters_by_ft = {
        c = { "astyle" },
        cpp = { "astyle" },
        css = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        pascal = { "pasfmt" },
        php = { "pint" },
        python = { "black" },
        rust = { "rustfmt" },
        scss = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
    },
})
vim.keymap.set("n", "<A-f>", function()
    conform.format({
        async = true,
        lsp_fallback = false,
    })
end)
