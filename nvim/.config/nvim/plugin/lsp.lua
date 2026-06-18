vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false
vim.lsp.config("*", {
    capabilities = capabilities,
})

local mason = require("mason")
mason.setup({
    ui = {
        border = "single",
        icons = {
            package_installed = "󰄬",
            package_pending = "󰁅",
            package_uninstalled = "󰅖",
        },
    },
})

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
