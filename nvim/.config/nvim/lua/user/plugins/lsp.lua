return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.config("*", {
                capabilities = vim.lsp.protocol.make_client_capabilities(),
            })
        end,
    },
    {
        "mason-org/mason.nvim",
        config = function()
            local mason = require("mason")
            mason.setup({
                ui = {
                    icons = {
                        package_installed = "󰄬",
                        package_pending = "󰁅",
                        package_uninstalled = "󰅖",
                    },
                },
            })
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        config = function()
            local lspconfig = require("mason-lspconfig")
            lspconfig.setup({
                ensure_installed = {
                    "clangd",
                    "intelephense",
                    "jsonls",
                    "lua_ls",
                    "ts_ls",
                },
            })
        end,
    },
}
