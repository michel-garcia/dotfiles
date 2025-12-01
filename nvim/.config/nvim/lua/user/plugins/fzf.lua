return {
    {
        "ibhagwan/fzf-lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            files = {
                cwd_prompt = false,
                git_icons = false,
            },
            fzf_colors = {
                true,
                ["bg"] = "-1",
                ["gutter"] = "-1",
                ["header"] = "-1",
            },
            fzf_opts = {
                ["--no-scrollbar"] = true,
                ["--no-unicode"] = true,
                ["--separator"] = " ",
            },
            winopts = {
                border = "single",
                preview = {
                    border = "single",
                    wrap = true,
                },
                title_flags = false,
            },
        },
        config = function(_, opts)
            local fzf = require("fzf-lua")
            fzf.setup(opts)
            vim.keymap.set("n", "<leader>ff", fzf.files)
            vim.keymap.set("n", "<leader>fb", fzf.buffers)
            vim.keymap.set("n", "<leader>fg", fzf.live_grep)
            vim.keymap.set("n", "<leader>fh", fzf.help_tags)
        end,
    },
    {
        "michel-garcia/fzf-lua-file-browser.nvim",
        dev = true,
        dependencies = {
            "ibhagwan/fzf-lua",
        },
        opts = {
            cwd_header = true,
            cwd_prompt = false,
            hijack_netrw = true,
        },
        config = function(_, opts)
            local file_browser = require("fzf-lua-file-browser")
            file_browser.setup(opts)
            local fzf = require("fzf-lua")
            vim.keymap.set("n", "<leader>fe", fzf.file_browser)
        end,
    },
}
