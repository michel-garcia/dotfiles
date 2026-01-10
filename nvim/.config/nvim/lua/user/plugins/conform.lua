return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters = {
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
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                json = { "prettier" },
                lua = { "stylua" },
                php = { "pint" },
                python = { "black" },
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
    end,
}
