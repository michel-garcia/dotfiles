vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false
vim.lsp.config("*", {
    capabilities = capabilities,
})

vim.lsp.enable({
    "clangd",
    "lua_ls",
    "pyright",
    "phpantom_lsp",
    "ts_ls",
})
