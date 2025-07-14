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
        styles = {
            dashboard = {
                wo = {
                    winhighlight = table.concat({
                        "SnacksDashboardHeader:@function",
                        "SnacksDashboardDesc:@operator",
                    }, ","),
                },
            },
        },
    },
}
