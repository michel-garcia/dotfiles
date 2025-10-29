return {
    "Saghen/blink.cmp",
    opts = {
        cmdline = {
            completion = {
                ghost_text = {
                    enabled = false,
                },
                menu = {
                    auto_show = true,
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
                scrollbar = false,
            },
        },
        fuzzy = {
            implementation = "lua",
        },
        signature = {
            window = {
                border = "solid",
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            per_filetype = {
                lua = {
                    inherit_defaults = true,
                    "lazydev",
                },
            },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },
    },
}
