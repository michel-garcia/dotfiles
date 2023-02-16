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
            context = {
                function ()
                    local ok, navic = pcall(require, "nvim-navic")
                    if ok then
                        return navic.get_location()
                    end
                end
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
                "filename",
                symbols = {
                    modified = "ﱣ ",
                    newfile = "New File",
                    readonly = " ",
                    unnamed = "Unnamed"
                }
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
            tabs = {
                "tabs",
                tabs_color = {
                    active = "lualine_a_insert",
                    inactive = "lualine_b_insert"
                }
            },
            title = {
                function ()
                    local version = vim.version()
                    return string.format(
                        " NeoVim %s.%s.%s",
                        version.major,
                        version.minor,
                        version.patch
                    )
                end,
                color = "@type"
            }
        }
        local lualine = require("lualine")
        lualine.setup({
            inactive_sections = {},
            inactive_winbar = {
                lualine_c = {
                    components.filename,
                    components.context
                }
            },
            options = {
                component_separators = "",
                disabled_filetypes = {
                    statusline = { "dashboard" },
                    winbar = { "dashboard" }
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
                    components.title
                },
                lualine_c = {
                    components.tabs
                }
            },
            winbar = {
                lualine_c = {
                    components.filename,
                    components.context
                }
            }
        })
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function ()
                vim.cmd("hi lualine_c_inactive none")
                vim.cmd("hi link lualine_c_inactive lualine_c_normal")
            end,
            group = vim.api.nvim_create_augroup("LualineHighlights", {
                clear = true
            })
        })
    end
}

