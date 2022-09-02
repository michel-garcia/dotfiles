function get_server_config (server_name)
    local completion = require("cmp_nvim_lsp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    completion.update_capabilities(capabilities)
    local config = {
        capabilities = capabilities,
        on_attach = function (client, buffer)
            local mappings = require("mappings.buffer")
            mappings.bind(buffer)
            local illuminate = require("illuminate")
            illuminate.on_attach(client)
        end
    }
    local filename = string.format("lsp.%s", server_name)
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
        "RRethy/vim-illuminate"
    },
    config = function ()
        local servers = {
            "ccls",
            "intelephense",
            "jsonls",
            "sumneko_lua",
            "tsserver"
        }
        local mason = require("mason")
        mason.setup()
        local lspconfig = require("lspconfig")
        for _, server_name in ipairs(servers) do
            local server = lspconfig[server_name]
            local config = get_server_config(server_name)
            server.setup(config)
        end
    end
}

