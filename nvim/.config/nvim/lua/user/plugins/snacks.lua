local version = vim.version()

return {
    "folke/snacks.nvim",
    opts = {
        bigfile = {
            line_length = 1000,
        },
        dashboard = {
            formats = {
                icon = function()
                    return {}
                end,
            },
            sections = {
                {
                    section = "header",
                },
                {
                    text = {
                        string.format("Version %s.%s.%s", version.major, version.minor, version.patch),
                        hl = "@character",
                    },
                    align = "center",
                    padding = 3,
                },
                {
                    section = "keys",
                    gap = 1,
                },
            },
        },
        indent = {
            animate = {
                enabled = false,
            },
            scope = {
                enabled = false,
            },
        },
    },
    config = function(_, opts)
        local snacks = require("snacks")
        snacks.setup(opts)
        vim.api.nvim_set_hl(0, "SnacksDashboardHeader", {
            link = "@function",
        })
        vim.api.nvim_set_hl(0, "SnacksDashboardDesc", {
            link = "@operator",
        })
    end,
}
