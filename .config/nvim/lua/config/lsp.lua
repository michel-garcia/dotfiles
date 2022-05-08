local installer = require("nvim-lsp-installer")

vim.diagnostic.config({
    severity_sort = true,
    underline = true,
    virtual_text = true
})

installer.on_server_ready(function (server)
    local configurations = {
        ["intelephense"] = {
            root_dir = function (_)
                return vim.loop.cwd()
            end
        },
        ["sumneko_lua"] = {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        }
    }
    local opts = configurations[server.name] or {}
    server:setup(opts)
end)
