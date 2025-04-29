return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
        bottom = {
            {
                filter = function(_, win)
                    return vim.api.nvim_win_get_config(win).relative == ""
                end,
                ft = "toggleterm",
                size = {
                    height = 0.25,
                },
            },
        },
        exit_when_last = true,
        wo = {
            winhighlight = "",
        },
    },
}
