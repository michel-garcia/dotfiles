return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/playground",
        },
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "bash",
                "blade",
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
                "yaml",
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = false,
            },
            playground = {
                enable = true,
            },
            textobjects = {
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        ["]a"] = "@parameter.inner",
                        ["]r"] = "@return.outer",
                        ["]x"] = "@call.outer",
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[a"] = "@parameter.inner",
                        ["[r"] = "@return.outer",
                        ["[x"] = "@call.outer",
                    },
                },
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["ax"] = "@call.outer",
                        ["ix"] = "@call.inner",
                    },
                },
            },
        },
        config = function(_, opts)
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup(opts)
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.g._ts_force_sync_parsing = true
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {
            opts = {
                enable_close = false,
            },
        },
    },
}
