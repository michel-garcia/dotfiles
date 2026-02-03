return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local lualine = require("lualine")
        local get_sign = function(severity)
            local config = vim.diagnostic.config()
            if not config then
                return
            end
            return table.concat({
                config.signs.text[severity],
                string.char(32),
            })
        end
        lualine.setup({
            inactive_sections = {},
            inactive_winbar = {
                lualine_c = {
                    {
                        "filename",
                        color = "lualine_b_insert",
                        symbols = {
                            modified = "●",
                        },
                    },
                },
            },
            options = {
                always_show_tabline = false,
                component_separators = "",
                icons_enabled = false,
                section_separators = "",
            },
            sections = {
                lualine_a = {
                    "mode",
                },
                lualine_b = {},
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                        symbols = {
                            modified = "●",
                        },
                    },
                    {
                        "diagnostics",
                        colored = false,
                        symbols = {
                            error = get_sign(vim.diagnostic.severity.ERROR),
                            warn = get_sign(vim.diagnostic.severity.WARN),
                            info = get_sign(vim.diagnostic.severity.INFO),
                            hint = get_sign(vim.diagnostic.severity.HINT),
                        },
                        update_in_insert = true,
                    },
                },
                lualine_x = {
                    "filetype",
                    "location",
                },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {
                lualine_b = {
                    {
                        "tabs",
                        tabs_color = {
                            active = "@function",
                            inactive = "lualine_c_insert",
                        },
                    },
                },
            },
            winbar = {
                lualine_c = {
                    {
                        "filename",
                        color = "lualine_a_insert",
                        symbols = {
                            modified = "●",
                        },
                    },
                    {
                        function()
                            return string.char(32)
                        end,
                    },
                },
            },
        })
        vim.api.nvim_create_autocmd({ "ColorScheme", "UIEnter" }, {
            callback = function()
                vim.api.nvim_set_hl(0, "StatusLine", {
                    bg = "none",
                })
                vim.api.nvim_set_hl(0, "StatusLineNC", {
                    bg = "none",
                })
                vim.api.nvim_set_hl(0, "TabLine", {
                    bg = "none",
                })
                vim.api.nvim_set_hl(0, "WinBar", {
                    bg = "none",
                })
                vim.api.nvim_set_hl(0, "WinBarNC", {
                    bg = "none",
                })
            end,
        })
    end,
}
