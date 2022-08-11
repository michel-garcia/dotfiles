function filename()
    return {
        "filename",
        symbols = {
            modified = " "
        }
    }
end

function branch()
    return {
        "branch",
        icons_enabled = true
    }
end

function diagnostics()
    return {
        "diagnostics",
        always_visible = true,
        colored = false,
        sources = {
            "nvim_diagnostic"
        },
        symbols = {
            error = " ",
            warn = " ",
            info = " ",
            hint = " "
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

function indentation()
    return {
        function ()
            return string.format(
                "Spaces: %s",
                vim.api.nvim_buf_get_option("shiftwidth")
            )
        end
    }
end

function encoding()
    return {
        function ()
            local encoding = vim.api.nvim_get_option("fileencoding")
            return string.upper(encoding)
        end
    }
end

function fileformat()
    local systems = {
        ["dos"] = "CRLF",
        ["mac"] = "CR",
        ["unix"] = "LF"
    }
    return {
        function ()
            local format = vim.api.nvim_buf_get_option("format")
            return systems[format]
        end
    }
end

function filetype()
    return {
        function ()
            local filetype = vim.api.nvim_buf_get_option("filetype")
            return table.concat({
                string.upper(string.sub(filetype, 1, 1)),
                string.sub(filetype, 2)
            })
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
                    filename(),
                    branch(),
                    diagnostics()
                },
                lualine_x = {
                    location(),
                    indentation(),
                    encoding(),
                    fileformat(),
                    filetype()
                },
                lualine_y = {},
                lualine_z = {}
            }
        })
    end
}

