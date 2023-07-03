return {
    {
        "ibhagwan/fzf-lua",
        config = function ()
            local fzf = require("fzf-lua")
            fzf.setup({
                buffers = {
                    fzf_opts = {
                        ["--info"] = false
                    },
                    no_header = true
                },
                files = {
                    cwd_prompt = false,
                    file_icons = false,
                    fzf_opts = {
                        ["--info"] = false
                    },
                    git_icons = false,
                    path_shorten = true,
                    prompt = "Files> "
                },
                fzf_opts = {
                    ["--algo"] = "v1",
                    ["--color"] = table.concat({
                        "bg+:6",
                        "fg+:0",
                        "hl:-1",
                        "hl+:0",
                        "gutter:-1",
                        "pointer:0",
                        "prompt:6"
                    }, ","),
                    ["--no-info"] = "",
                    ["--no-scrollbar"] = "",
                    ["--scroll-off"] = 5
                },
                grep = {
                    fzf_opts = {
                        ["--info"] = false
                    },
                    no_header = true
                },
                tabs = {
                    fzf_opts = {
                        ["--info"] = false
                    },
                    no_header = true
                },
                winopts = {
                    hl = {
                        border = "FloatBorder",
                        normal = "FloatBorder"
                    },
                    preview = {
                        hidden = "hidden"
                    }
                },
                winopts_fn = function ()
                    return {
                        border = "single",
                        col = .5,
                        height = 15,
                        row = .5,
                        width = 80
                    }
                end
            })
            local opts = {
                noremap = true,
                silent = true
            }
            vim.keymap.set("n", "<leader>fb", fzf.buffers, opts)
            vim.keymap.set("n", "<leader>ff", fzf.files, opts)
            vim.keymap.set("n", "<leader>sh", fzf.help_tags, opts)
            vim.keymap.set("n", "<leader>fg", fzf.live_grep, opts)
        end
    },
    {
        "michel-garcia/fzf-lua-file-browser.nvim",
        dev = true,
        dependencies = {
            "ibhagwan/fzf-lua"
        },
        config = function ()
            local file_browser = require("fzf-lua-file-browser")
            file_browser.setup({
                hidden = true
            })
            local opts = {
                noremap = true,
                silent = true
            }
            local fzf = require("fzf-lua")
            vim.keymap.set("n", "<leader>fe", fzf.file_browser, opts)
        end
    }
}

