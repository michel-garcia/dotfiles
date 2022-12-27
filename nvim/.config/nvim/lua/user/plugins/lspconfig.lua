return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "SmiteshP/nvim-navic"
    },
    config = function ()
        local lsp = require("user.lsp")
        local lspconfig = require("lspconfig")
        for _, server_name in ipairs(lsp.servers) do
            local server = lspconfig[server_name]
            local config = lsp.get_server_config(server_name)
            server.setup(config)
        end
    end
}

