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
        left = {
            filter = function(buf)
                return vim.b[buf].neo_tree_source == "filesystem"
            end,
            ft = "neo-tree",
            size = {
                height = 0.4,
            },
            title = "File system",
        },
    },
}
