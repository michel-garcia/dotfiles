return {
    "nvim-lualine/lualine.nvim",
    config = function ()
        local function get_sign(name)
            local signs = vim.fn.sign_getdefined(name)
            local sign = signs[1]
            if sign then
                return sign.text
            end
        end
        local components = {
            branch = {
                "branch",
                icons_enabled = true
            },
            diagnostics = {
                "diagnostics",
                always_visible = true,
                colored = false,
                symbols = {
                    error = get_sign("DiagnosticSignError"),
                    warn = get_sign("DiagnosticSignWarn"),
                    info = get_sign("DiagnosticSignInfo"),
                    hint = get_sign("DiagnosticSignHint")
                }
            },
            filename = {
                function ()
                    local buftype = vim.api.nvim_buf_get_option(0, "buftype")
                    if buftype == "terminal" then
                        return buftype
                    end
                    local filename = vim.api.nvim_buf_get_name(0)
                    if filename == "" then
                        return "New File"
                    end
                    filename = vim.fn.fnamemodify(filename, ":~:.")
                    local modified = vim.api.nvim_buf_get_option(0, "modified")
                    if modified then
                        filename = string.format("%s %s", "\u{ea71}", filename)
                    end
                    return filename
                end,
                color = function ()
                    local win = tonumber(vim.g.actual_curwin)
                    if win == vim.api.nvim_get_current_win() then
                        return "lualine_a_insert"
                    else
                        return "lualine_b_insert"
                    end
                end
            },
            filetype = {
                "filetype"
            },
            location = {
                "location"
            },
            mode = {
                "mode"
            },
            spacer = {
                function ()
                    return string.char(32)
                end,
                color = "lualine_c_normal"
            },
            tabs = {
                "tabs",
                tabs_color = {
                    active = "@function",
                    inactive = "lualine_c_insert"
                }
            }
        }
        local lualine = require("lualine")
        lualine.setup({
            inactive_sections = {},
            inactive_winbar = {
                lualine_c = {
                    components.filename,
                    components.spacer
                }
            },
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
                    components.mode
                },
                lualine_b = {},
                lualine_c = {
                    components.branch,
                    components.diagnostics
                },
                lualine_x = {
                    components.location,
                    components.filetype
                },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {
                lualine_b = {
                    components.tabs
                }
            },
            winbar = {
                lualine_c = {
                    components.filename,
                    components.spacer
                }
            }
        })
        vim.opt.showtabline = 1
    end
}

