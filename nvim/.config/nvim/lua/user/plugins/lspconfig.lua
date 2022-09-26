function on_attach(client, buffer)
    local illuminate = require("illuminate")
    illuminate.on_attach(client)
    local opts = {
        buffer = buffer,
        noremap = true,
        silent = true
    }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
end

function get_server_config (server_name)
    local completion = require("cmp_nvim_lsp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    completion.update_capabilities(capabilities)
    local config = {
        capabilities = capabilities,
        on_attach = on_attach
    }
    local filename = string.format("user.langs.%s", server_name)
    local ok, custom = pcall(require, filename)
    if ok then
        config = vim.tbl_deep_extend("force", custom, config)
    end
    return config
end

return {
    "neovim/nvim-lspconfig",
    requires = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "RRethy/vim-illuminate"
    },
    config = function ()
        local servers = {
            "clangd",
            "intelephense",
            "jsonls",
            "sumneko_lua",
            "tsserver"
        }
        local mason = require("mason")
        mason.setup({
            ui = {
                border = "single"
            }
        })
        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            ensure_installed = servers
        })
        local lspconfig = require("lspconfig")
        for _, server_name in ipairs(servers) do
            local server = lspconfig[server_name]
            local config = get_server_config(server_name)
            server.setup(config)
        end
    end
}

