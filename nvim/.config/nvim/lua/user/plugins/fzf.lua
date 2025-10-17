return {
    {
        "ibhagwan/fzf-lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            defaults = {
                color_icons = false,
            },
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
            winopts = function()
                local height = vim.api.nvim_win_get_height(0)
                local width = vim.api.nvim_win_get_width(0)
                return {
                    border = "single",
                    col = 0.5,
                    height = math.max(math.ceil(height * 0.4), 15),
                    preview = {
                        hidden = "hidden",
                    },
                    row = 0.5,
                    width = math.max(math.ceil(width * 0.5), 80),
                }
            end,
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
            hidden = true,
        },
        config = function(_, opts)
            local file_browser = require("fzf-lua-file-browser")
            file_browser.setup(opts)
            local fzf = require("fzf-lua")
            vim.keymap.set("n", "<leader>fe", fzf.file_browser)
        end,
    },
}
