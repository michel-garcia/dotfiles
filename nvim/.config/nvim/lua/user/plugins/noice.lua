return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            progress = {
                enabled = false,
            },
            signature = {
                auto_open = false,
            },
        },
        messages = {
            view_search = false,
        },
        presets = {
            bottom_search = false,
            command_palette = true,
            inc_rename = false,
            long_message_to_split = true,
            lsp_doc_border = false,
        },
        views = {
            cmdline_input = {
                border = {
                    style = "solid",
                },
                win_options = {
                    winhighlight = {
                        FloatNormal = "NormalFloat",
                        FloatTitle = "lualine_a_insert",
                        Normal = "NormalFloat",
                    },
                },
            },
            cmdline_popup = {
                border = {
                    style = "solid",
                },
                win_options = {
                    winhighlight = {
                        FloatNormal = "NormalFloat",
                        FloatTitle = "lualine_a_insert",
                        Normal = "NormalFloat",
                    },
                },
            },
            confirm = {
                border = {
                    style = "solid",
                },
                win_options = {
                    winhighlight = {
                        FloatNormal = "NormalFloat",
                        FloatTitle = "lualine_a_insert",
                        Normal = "NormalFloat",
                    },
                },
            },
            hover = {
                border = {
                    padding = { 0, 1 },
                    style = "solid",
                },
                position = {
                    col = 0,
                    row = 2,
                },
            },
        },
    },
    config = function(_, opts)
        local noice = require("noice")
        noice.setup(opts)
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleLua", {
            link = "lualine_a_insert",
        })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconLua", {
            link = "@function",
        })
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleHelp", {
            link = "lualine_a_insert",
        })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconHelp", {
            link = "@function",
        })
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleInput", {
            link = "lualine_a_insert",
        })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconInput", {
            link = "@function",
        })
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleFilter", {
            link = "lualine_a_insert",
        })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconFilter", {
            link = "@function",
        })
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleSearch", {
            link = "lualine_a_insert",
        })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", {
            link = "@function",
        })
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleCmdline", {
            link = "lualine_a_insert",
        })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconCmdline", {
            link = "@function",
        })
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleCalculator", {
            link = "lualine_a_insert",
        })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconCalculator", {
            link = "@function",
        })
    end,
}
