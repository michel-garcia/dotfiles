vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false
vim.lsp.config("*", {
    capabilities = capabilities,
})

vim.lsp.config('csharp_ls', {
    cmd = {
        'csharp-ls'
    },
    filetypes = {
        'cs'
    },
    root_markers = {
        '*.sln',
        '*.csproj',
        '.git'
    },
})

vim.lsp.enable({
    "clangd",
    "csharp_ls",
    "intelephense",
    "lua_ls",
    "pyright",
    "ts_ls",
})
