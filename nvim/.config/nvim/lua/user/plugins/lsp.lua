return {
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                border = "solid",
                icons = {
                    package_installed = "󰄬",
                    package_pending = "󰁅",
                    package_uninstalled = "󰅖",
                },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local win = require("lspconfig.ui.windows")
            win.default_options.border = "solid"
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "clangd",
                "intelephense",
                "jsonls",
                "lua_ls",
                "ts_ls",
            },
        },
    },
}
