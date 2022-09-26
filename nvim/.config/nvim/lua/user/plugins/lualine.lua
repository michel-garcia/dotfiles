function branch()
    return {
        "branch",
        icons_enabled = true
    }
end

function diagnostics()
    local function get_sign(name)
        local signs = vim.fn.sign_getdefined(name)
        local sign = signs[1]
        if sign then
            return sign.text
        end
    end
    return {
        "diagnostics",
        always_visible = true,
        colored = false,
        sources = {
            "nvim_diagnostic"
        },
        symbols = {
            error = get_sign("DiagnosticSignError"),
            warn = get_sign("DiagnosticSignWarn"),
            info = get_sign("DiagnosticSignInfo"),
            hint = get_sign("DiagnosticSignHint")
        }
    }
end

function location()
    return {
        function ()
            local line = vim.fn.line(".")
            local col = vim.fn.col(".")
            return string.format(
                "Ln %s, Col %s",
                line,
                col
            )
        end
    }
end

function filetype()
    return {
        function ()
            local filetype = vim.api.nvim_buf_get_option(
                0,
                "filetype"
            )
            return filetype
        end
    }
end

return {
    "nvim-lualine/lualine.nvim",
    config = function ()
        local lualine = require("lualine")
        lualine.setup({
            inactive_sections = {},
            options = {
                component_separators = "",
                icons_enabled = false,
                section_separators = ""
            },
            sections = {
                lualine_a = {
                    "mode",
                },
                lualine_b = {},
                lualine_c = {
                    branch(),
                    diagnostics()
                },
                lualine_x = {
                    location(),
                    filetype()
                },
                lualine_y = {},
                lualine_z = {}
            }
        })
    end
}

