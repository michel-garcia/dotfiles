return {
    {
        "nvim-tree/nvim-web-devicons",
    },
    {
        "ibhagwan/fzf-lua",
        config = function()
            local fzf = require("fzf-lua")
            fzf.setup({
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
                grep = {
                    rg_opts = table.concat({
                        "--column",
                        "--hidden",
                        "--line-number",
                    }, " "),
                },
                winopts = {
                    border = "single",
                    preview = {
                        border = "single",
                        wrap = true,
                    },
                    title_flags = false,
                },
            })
            vim.keymap.set("n", "<leader>ff", fzf.files)
            vim.keymap.set("n", "<leader>fb", fzf.buffers)
            vim.keymap.set("n", "<leader>fg", fzf.live_grep)
            vim.keymap.set("n", "<leader>fh", fzf.help_tags)
            vim.keymap.set("n", "<leader>fq", fzf.quickfix)
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    vim.schedule(function()
                        vim.api.nvim_buf_delete(args.buf, {
                            force = true,
                        })
                        fzf.quickfix()
                    end)
                end,
                group = vim.api.nvim_create_augroup("FzfLuaQuickFix", {
                    clear = true,
                }),
                pattern = "qf",
            })
        end,
    },
    {
        "michel-garcia/fzf-lua-file-browser.nvim",
        config = function()
            local file_browser = require("fzf-lua-file-browser")
            file_browser.setup({
                cwd_header = true,
                cwd_prompt = false,
                hijack_netrw = true,
            })
            local fzf = require("fzf-lua")
            vim.keymap.set("n", "<leader>fe", fzf.file_browser)
        end,
    },
}
