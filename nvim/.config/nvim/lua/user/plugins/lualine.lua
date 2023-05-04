return {
    "nvim-lualine/lualine.nvim",
    config = function ()
        local lualine = require("lualine")
        lualine.setup({
            inactive_sections = {},
            options = {
                component_separators = "",
                disabled_filetypes = {
                    "alpha"
                },
                icons_enabled = false,
                section_separators = ""
            },
            sections = {
                lualine_a = {
                    "mode"
                },
                lualine_b = {},
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                        shorting_target = 100
                    },
                    "diagnostics"
                },
                lualine_x = {
                    "filetype",
                    "location"
                },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {
                lualine_b = {
                    {
                        "tabs",
                        tab_color = {
                            active = "@function",
                            inactive = "lualine_c_insert"
                        }
                    }
                }
            }
        })
    end
}

