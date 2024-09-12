return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig"
        },
        config = function ()
            local mason = require("mason")
            mason.setup({
                ui = {
                    border = "solid",
                    icons = {
                        package_installed = "󰄬",
                        package_pending = "󰁅",
                        package_uninstalled = "󰅖"
                    }
                }
            })
            local lsp = require("mason-lspconfig")
            lsp.setup({
                ensure_installed = {
                    "clangd",
                    "intelephense",
                    "jsonls",
                    "lua_ls",
                    "ts_ls"
                }
            })
            local lspconfig = require("lspconfig")
            lsp.setup_handlers({
                function (server_name)
                    local cmp = require("cmp_nvim_lsp")
                    local path = string.format("user.lsp.%s", server_name)
                    local ok, config = pcall(require, path)
                    local opts = vim.tbl_deep_extend("force", {
                        capabilities = cmp.default_capabilities()
                    }, ok and config or {})
                    lspconfig[server_name].setup(opts)
                end
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function ()
            local win = require("lspconfig.ui.windows")
            win.default_options.border = "solid"
        end
    }
}

