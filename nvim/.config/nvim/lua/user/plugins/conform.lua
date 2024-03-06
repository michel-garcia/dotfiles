return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.setup()
        vim.keymap.set("n", "<A-f>", function()
            conform.format({
                async = true,
                lsp_fallback = true
            })
        end, {
            noremap = true,
            silent = true
        })
    end
}
