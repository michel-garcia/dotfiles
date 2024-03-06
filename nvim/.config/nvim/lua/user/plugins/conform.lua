return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                php = { "pretty-php" }
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
