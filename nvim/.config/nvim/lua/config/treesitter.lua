return {
    "nvim-treesitter/nvim-treesitter",
    requires = {
        "windwp/nvim-ts-autotag"
    },
    run = ":TSUpdate",
    config = function ()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            autotag = { enable = true },
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "dart",
                "glsl",
                "html",
                "javascript",
                "json",
                "lua",
                "make",
                "php",
                "python",
                "typescript"
            },
            highlight = { enable = true },
            ignore_install = { "phpdoc" },
            indent = { enable = false }
        })
    end
}

