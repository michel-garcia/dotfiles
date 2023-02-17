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
                    if not ok then
                        return string.char(32)
                    end
                    local context = navic.get_location()
                    if context == "" then
                        return string.char(32)
                    end
                    if context:len() > 80 then
                        context = string.format("%s...", context:sub(1, 80))
                    end
                    return context
                end,
                color = "lualine_c_normal"
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
                    local filename = vim.api.nvim_buf_get_name(0)
                    if filename == "" then
                        return "New File"
                    end
                    filename = vim.fn.fnamemodify(filename, ":t")
                    local modified = vim.api.nvim_buf_get_option(0, "modified")
                    if modified then
                        filename = string.format("%s %s", "\u{ea71}", filename)
                    end
                    return filename
                end,
                color = "lualine_a_insert"
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
                    active = "@function",
                    inactive = "lualine_c_insert"
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
        --[[ vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function ()
                vim.cmd("hi lualine_c_inactive none")
                vim.cmd("hi link lualine_c_inactive lualine_c_normal")
            end,
            group = vim.api.nvim_create_augroup("LualineHighlights", {
                clear = true
            })
        }) ]]
    end
}

