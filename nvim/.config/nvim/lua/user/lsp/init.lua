return {
    get_server_config = function (server_name)
        local cmp = require("cmp_nvim_lsp")
        local defaults = {
            capabilities = cmp.default_capabilities()
        }
        local filename = string.format("user.lsp.%s", server_name)
        local ok, config = pcall(require, filename)
        if not ok then
            return defaults
        end
        return vim.tbl_deep_extend("force", config, defaults)
    end,
    servers = {
        "clangd",
        "intelephense",
        "jsonls",
        "lua_ls",
        "tsserver"
    }
}

