return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/playground",
        "windwp/nvim-ts-autotag"
    },
    build = ":TSUpdate",
    config = function ()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            autotag = {
                enable = true,
                enable_close = false
            },
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "dart",
                "glsl",
                "html",
                "http",
                "javascript",
                "json",
                "lua",
                "make",
                "php",
                "python",
                "query",
                "sql",
                "typescript",
                "vimdoc",
                "yaml"
            },
            highlight = {
                disable = function (_, bufnr)
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
            },
            playground = {
                enable = true
            }
        })
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end
}

