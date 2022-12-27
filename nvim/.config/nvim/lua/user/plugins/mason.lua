return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim"
    },
    config = function ()
        local mason = require("mason")
        mason.setup({
            ui = {
                border = "single",
                icons = {
                    package_installed = "",
                    package_pending = "",
                    package_uninstalled = ""
                }
            }
        })
        local lsp = require("user.lsp")
        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            ensure_installed = lsp.servers
        })
    end
}

