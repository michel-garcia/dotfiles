return {
    "Saghen/blink.cmp",
    opts = {
        cmdline = {
            completion = {
                ghost_text = {
                    enabled = false,
                },
            },
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
                window = {
                    border = "solid",
                },
            },
            list = {
                selection = {
                    preselect = false,
                },
            },
            menu = {
                border = "solid",
                draw = {
                    columns = {
                        { "kind_icon", "label", gap = 1 },
                    },
                    components = {
                        kind_icon = {
                            highlight = "CmpItemKind",
                        },
                    },
                },
            },
        },
        fuzzy = {
            implementation = "lua",
        },
        signature = {
            enabled = true,
            window = {
                border = "solid",
            },
        },
    },
}
