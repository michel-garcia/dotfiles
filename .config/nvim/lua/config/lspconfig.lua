return {
    "neovim/nvim-lspconfig",
    requires = {
        -- "RRethy/vim-illuminate",
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
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        require("cmp_nvim_lsp").update_capabilities(capabilities)
        for _, server in ipairs(servers) do
            local filename = "lsp" .. "." .. server
            local configuration = {
                capabilities = capabilities,
                on_attach = function (client)
                    -- require("illuminate").on_attach(client)
                end
            }
            local found, settings = pcall(require, filename)
            if found then
                configuration = vim.tbl_deep_extend("force", settings, configuration)
            end
            lspconfig[server].setup(configuration)
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

