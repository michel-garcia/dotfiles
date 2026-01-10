return {
    {
        "nvim-mini/mini.cmdline",
        config = function()
            local cmdline = require("mini.cmdline")
            cmdline.setup()
        end,
    },
    {
        "nvim-mini/mini.completion",
        config = function()
            local completion = require("mini.completion")
            completion.setup({
                delay = {
                    completion = 0,
                    info = 0,
                    signature = 0,
                },
                window = {
                    signature = {
                        border = "none",
                    },
                },
            })
            vim.api.nvim_create_autocmd("User", {
                callback = function(args)
                    local config = vim.api.nvim_win_get_config(args.data.win_id)
                    config.title = ""
                    vim.api.nvim_win_set_config(args.data.win_id, config)
                end,
                pattern = "MiniCompletionWindowOpen",
                group = vim.api.nvim_create_augroup("MiniCompletionCustomization", {
                    clear = true,
                }),
            })
        end,
    },
    {
        "nvim-mini/mini.ai",
        config = function()
            local ai = require("mini.ai")
            ai.setup()
        end,
    },
    {
        "nvim-mini/mini.cursorword",
        config = function()
            local cursorword = require("mini.cursorword")
            cursorword.setup({
                delay = 0,
            })
        end,
    },
    {
        "nvim-mini/mini.icons",
        config = function()
            local icons = require("mini.icons")
            icons.setup()
            icons.tweak_lsp_kind()
        end,
    },
    {
        "nvim-mini/mini.jump",
        config = function()
            local jump = require("mini.jump")
            jump.setup()
        end,
    },
    {
        "nvim-mini/mini.surround",
        config = function()
            local surround = require("mini.surround")
            surround.setup()
        end,
    },
    {
        "nvim-mini/mini.splitjoin",
        config = function()
            local splitjoin = require("mini.splitjoin")
            splitjoin.setup()
        end,
    },
}
