local get_sign = function (name)
    local sign = vim.fn.sign_getdefined(name)[1]
    if sign then
        return sign.text
    end
end

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
                        function ()
                            local buftype = vim.api.nvim_buf_get_option(
                                0, "buftype"
                            )
                            if buftype ~= "" then
                                return buftype
                            end
                            local path = vim.fn.fnamemodify(
                                vim.api.nvim_buf_get_name(0), ":~:."
                            )
                            local parts = vim.split(path, "/")
                            for i = 1, #parts - 1 do
                                local part = parts[i]
                                parts[i] = part:sub(
                                    1, vim.startswith(part, ".") and 2 or 1
                                )
                            end
                            local filename = table.concat(parts, "/")
                            local modified = vim.api.nvim_buf_get_option(
                                0, "modified"
                            )
                            if not modified then
                                return filename
                            end
                            return table.concat({ filename, "●" }, " ")
                        end
                    },
                    {
                        "diagnostics",
                        colored = false,
                        symbols = {
                            error = get_sign("DiagnosticSignError"),
                            warn = get_sign("DiagnosticSignWarn"),
                            info = get_sign("DiagnosticSignInfo"),
                            hint = get_sign("DiagnosticSignHint")
                        }
                    }
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
                        tabs_color = {
                            active = "@function",
                            inactive = "lualine_c_insert"
                        }
                    }
                }
            }
        })
    end
}

