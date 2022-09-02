return {
    "nvim-treesitter/nvim-treesitter",
    requires = {
        "windwp/nvim-ts-autotag"
    },
    run = ":TSUpdate",
    config = function ()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            autotag = {
                enable = true
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
                "sql",
                "typescript",
                "yaml"
            },
            highlight = {
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

