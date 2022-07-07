function get_server_configuration (server_name)
    local completion = require("cmp_nvim_lsp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    completion.update_capabilities(capabilities)
    local configuration = {
        capabilities = capabilities,
        on_attach = function (_)
        end
    }
    local filename = "lsp." .. server_name
    local found, settings = pcall(require, filename)
    if found then
        configuration = vim.tbl_deep_extend("force", settings, configuration)
    end
    return configuration
end

return {
    "neovim/nvim-lspconfig",
    requires = {
        "williamboman/nvim-lsp-installer"
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
            virtual_text = true
        })
    end
}

