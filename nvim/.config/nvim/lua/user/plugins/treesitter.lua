return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "dart",
                "glsl",
                "help",
                "html",
                "http",
                "javascript",
                "json",
                "lua",
                "make",
                "php",
                "python",
                "sql",
                "typescript",
                "yaml"
            },
            highlight = {
                disable = function (lang, bufnr)
                    if lang == "php" then
                        return true
                    end
                    local max = 128 * 1024
                    local filename = vim.api.nvim_buf_get_name(bufnr)
                    local ok, stats = pcall(vim.loop.fs_stat, filename)
                    if ok and stats and stats.size > max then
                        return true
                    end
                end,
                enable = true
            },
            indent = {
                enable = false
            }
        })
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end
}

