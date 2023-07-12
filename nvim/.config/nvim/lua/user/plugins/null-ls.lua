return {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function ()
        local null_ls = require("null-ls")
        null_ls.setup({
            border = vim.g.borders.frame,
            sources = {
                null_ls.builtins.formatting.astyle.with({
                    args = { "--indent=spaces=4", "--quiet" }
                }),
                null_ls.builtins.formatting.prettier.with({
                    args = { "--tab-width 4" }
                }),
                null_ls.builtins.formatting.stylua
            }
        })
        vim.keymap.set("n", "<A-f>", function ()
            vim.lsp.buf.format({ async = false })
        end, { noremap = true, silent = true })
    end
}
