return {
    {
        "ibhagwan/fzf-lua",
        config = function ()
            local fzf = require("fzf-lua")
            fzf.setup({
                files = {
                    file_icons = false,
                    find_opts = "-type f -not -path '*/.git/*' -not -path '*/node_modules/*' -printf '%P\n'",
                    git_icons = false
                },
                fzf_opts = {
                    ["--color"] = "bg+:-1,header:-1",
                    ["--info"] = "default",
                    ["--scroll-off"] = 5
                },
                grep = {
                    grep_opts = "--recursive --ignore-case --exclude-dir node_modules"
                },
                winopts = {
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
            vim.keymap.set("n", "<leader>pb", fzf.buffers, opts)
            vim.keymap.set("n", "<leader>pt", fzf.tabs, opts)
            vim.keymap.set("n", "<leader>sf", fzf.files, opts)
            vim.keymap.set("n", "<leader>sh", fzf.help_tags, opts)
            vim.keymap.set("n", "<leader>sg", fzf.live_grep, opts)
            vim.keymap.set("n", "<leader>ds", fzf.lsp_document_symbols, opts)
            vim.keymap.set("n", "<leader>sd", fzf.diagnostics_document, opts)
        end
    },
    {
        "michel-garcia/fzf-lua-file-browser.nvim",
        dependencies = {
            "ibhagwan/fzf-lua"
        },
        config = function ()
            local file_browser = require("fzf-lua-file-browser")
            file_browser.setup()
            local opts = {
                noremap = true,
                silent = true
            }
            local fzf = require("fzf-lua")
            vim.keymap.set("n", "<leader>fb", fzf.file_browser, opts)
        end
    }
}

