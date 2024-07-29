return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify"
    },
    opts = {
        cmdline = {
            format = {
                cmdline = {
                    icon = ">",
                    title = "Command Palette"
                }
            }
        },
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true
            },
            progress = {
                enabled = false
            },
            signature = {
                auto_open = false
            }
        },
        messages = {
            view_search = false
        },
        presets = {
            bottom_search = false,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false
        },
        views = {
            cmdline_input = {
                border = {
                    style = "solid"
                },
                win_options = {
                    winhighlight = {
                        FloatNormal = "NormalFloat",
                        FloatTitle = "lualine_a_insert",
                        Normal = "NormalFloat"
                    }
                }
            },
            cmdline_popup = {
                border = {
                    style = "solid"
                },
                win_options = {
                    winhighlight = {
                        FloatNormal = "NormalFloat",
                        FloatTitle = "lualine_a_insert",
                        Normal = "NormalFloat"
                    }
                }
            },
            confirm = {
                border = {
                    style = "solid"
                },
                win_options = {
                    winhighlight = {
                        FloatNormal = "NormalFloat",
                        FloatTitle = "lualine_a_insert",
                        Normal = "NormalFloat"
                    }
                }
            },
            hover = {
                border = {
                    padding = { 0, 1 },
                    style = "solid"
                },
                position = {
                    col = 0,
                    row = 2
                }
            }
        }
    },
    config = true
}
