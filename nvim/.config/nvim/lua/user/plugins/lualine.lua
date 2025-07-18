local get_sign = function(name)
    local sign = vim.fn.sign_getdefined(name)[1]
    if sign then
        return sign.text
    end
end

local filename = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local path = vim.fn.fnamemodify(bufname, ":~:.")
    local shorten_path = vim.fn.pathshorten(path)
    local modified = vim.api.nvim_get_option_value("modified", {})
    if not modified then
        return shorten_path
    end
    return table.concat({ shorten_path, "●" }, " ")
end

return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local lualine = require("lualine")
        lualine.setup({
            inactive_sections = {},
            inactive_winbar = {
                lualine_c = {
                    {
                        filename,
                        color = "lualine_b_insert",
                    },
                },
            },
            options = {
                always_show_tabline = false,
                component_separators = "",
                disabled_filetypes = {
                    "snacks_dashboard",
                },
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
                        filename,
                    },
                    {
                        "diagnostics",
                        colored = false,
                        symbols = {
                            error = get_sign("DiagnosticSignError"),
                            warn = get_sign("DiagnosticSignWarn"),
                            info = get_sign("DiagnosticSignInfo"),
                            hint = get_sign("DiagnosticSignHint"),
                        },
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
                        filename,
                        color = "lualine_a_insert",
                    },
                    {
                        function()
                            return " "
                        end,
                    },
                },
            },
        })
        vim.api.nvim_create_autocmd({ "ColorScheme", "UIEnter" }, {
            callback = function()
                vim.api.nvim_set_hl(0, "WinBar", {
                    bg = "none",
                })
                vim.api.nvim_set_hl(0, "WinBarNC", {
                    bg = "none",
                })
                vim.api.nvim_set_hl(0, "StatusLine", {
                    bg = "none",
                })
                vim.api.nvim_set_hl(0, "TabLine", {
                    bg = "none",
                })
            end,
        })
    end,
}
