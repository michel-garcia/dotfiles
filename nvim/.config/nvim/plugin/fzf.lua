vim.pack.add({
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/michel-garcia/fzf-lua-file-browser.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
})

local fzf = require("fzf-lua")
fzf.setup({
    file_ignore_patterns = {
        "node_modules",
        "vendor",
    },
    files = {
        cwd_prompt = false,
        git_icons = false,
        no_ignore = true,
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
        hidden = true,
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
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local opts = {
            buffer = args.buf,
        }
        vim.keymap.set("t", "<C-t>", function()
            local win = vim.api.nvim_get_current_win()
            vim.api.nvim_win_close(win, true)
            fzf.builtin()
        end, opts)
    end,
    group = vim.api.nvim_create_augroup("FzfLua", {
        clear = true,
    }),
    pattern = "fzf",
})
local file_browser = require("fzf-lua-file-browser")
file_browser.setup({
    cwd_header = true,
    cwd_prompt = false,
    hijack_netrw = true,
})
vim.keymap.set("n", "<leader>fe", fzf.file_browser)
