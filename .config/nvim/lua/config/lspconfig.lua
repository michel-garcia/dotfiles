function bind_buffer_mappings(buffer)
    local opts = {
        buffer = buffer
    }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, opts)
end

function get_server_configuration (server_name)
    local completion = require("cmp_nvim_lsp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    completion.update_capabilities(capabilities)
    local configuration = {
        capabilities = capabilities,
        on_attach = function (client, buffer)
            bind_buffer_mappings(buffer)
            vim.notify("Language server attached!", "info", {
                title = server_name
            })
            local illuminate = require("illuminate")
            illuminate.on_attach(client)
        end
    }
    local filename = string.format("lsp.%s", server_name)
    local found, custom_configuration = pcall(require, filename)
    if found then
        configuration = vim.tbl_deep_extend(
            "force",
            custom_configuration,
            configuration
        )
    end
    return configuration
end

return {
    "neovim/nvim-lspconfig",
    requires = {
        "williamboman/nvim-lsp-installer",
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
        local installer = require("nvim-lsp-installer")
        installer.setup({
            automatic_installation = true,
            ensure_installed = servers,
        })
        local lspconfig = require("lspconfig")
        for _, server_name in ipairs(servers) do
            local server = lspconfig[server_name]
            local configuration = get_server_configuration(server_name)
            server.setup(configuration)
        end
        vim.diagnostic.config({
            severity_sort = true,
            signs = false,
            underline = true,
            update_in_insert = true,
            virtual_text = false
        })
        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
        vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
    end
}

