return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/playground",
    },
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
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
                "yaml",
            },
            highlight = {
                disable = function(_, bufnr)
                    local max = 128 * 1024
                    local filename = vim.api.nvim_buf_get_name(bufnr)
                    local ok, stats = pcall(vim.uv.fs_stat, filename)
                    if ok and stats and stats.size > max then
                        return true
                    end
                end,
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
        })
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        local parsers = require("nvim-treesitter.parsers").get_parser_configs()
        parsers.blade = {
            filetype = "blade",
            install_info = {
                branch = "main",
                files = { "src/parser.c" },
                url = "https://github.com/EmranMR/tree-sitter-blade",
            },
        }
        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
            callback = function()
                vim.api.nvim_set_option_value("filetype", "blade", {})
            end,
            group = vim.api.nvim_create_augroup("BladeFiletype", {
                clear = true,
            }),
            pattern = "*.blade.php",
        })
    end,
}
