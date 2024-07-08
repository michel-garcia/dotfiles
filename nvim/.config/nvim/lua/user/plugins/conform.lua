return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                c = { "astyle" },
                cpp = { "astyle" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                lua = { "stylua" },
                php = { "pretty-php" },
                python = { "black" },
            }
        })
        vim.keymap.set("n", "<A-f>", function()
            conform.format({
                async = true,
                lsp_fallback = false
            })
        end, {
            noremap = true,
            silent = true
        })
    end
}
