function filename()
    return {
        function ()
            local filename = vim.fn.expand("%:t")
            local parts = {
                filename
            }
            local modified = vim.api.nvim_buf_get_option(0, "modified")
            if modified then
                table.insert(parts, "")
            end
            local readonly = vim.api.nvim_buf_get_option(0, "readonly")
            local modifiable = vim.api.nvim_buf_get_option(0, "modifiable")
            if readonly or not modifiable then
                table.insert(parts, "[READONLY]")
            end
            local ok, devicons = pcall(require, "nvim-web-devicons")
            if ok then
                local extension = vim.fn.expand("%:e")
                local icon = devicons.get_icon(filename, extension)
                table.insert(parts, 1, icon)
            end
            return table.concat(parts, " ")
        end
    }
end

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

function indentation()
    return {
        function ()
            return string.format(
                "Spaces: %s",
                vim.api.nvim_get_option("shiftwidth")
            )
        end
    }
end

function encoding()
    return {
        function ()
            local encoding = vim.api.nvim_buf_get_option(0, "fileencoding")
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
            local format = vim.api.nvim_buf_get_option(0, "format")
            return systems[format]
        end
    }
end

function filetype()
    return {
        function ()
            local filetype = vim.api.nvim_buf_get_option(0, "filetype")
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

