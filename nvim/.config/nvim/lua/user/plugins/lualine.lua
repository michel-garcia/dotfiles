local Diagnostics = function(config)
    local Diagnostics = require("lualine.component.diagnostics")
    local diagnostics = Diagnostics(config.options)
    return diagnostics:update_status()
end

local Filename = function(config)
    local ok, ergoterm = pcall(require, "ergoterm")
    if ok then
        local win = vim.api.nvim_get_current_win()
        local term = ergoterm.find(function(term)
            if term:get_state("window") == win then
                return term
            end
        end)
        if term then
            return term.name
        end
    end
    local Filename = require("lualine.components.filename")
    local filename = Filename(config.options)
    return filename:update_status()
end

local Filetype = function(config)
    local Filetype = require("lualine.components.filetype")
    local filetype = Filetype(config.options)
    return filetype:update_status()
end

local Location = function()
    local get_location = require("lualine.components.location")
    return get_location()
end

local Mode = function()
    local get_mode = require("lualine.components.mode")
    return get_mode()
end

local Spacer = function()
    return string.char(32)
end

local Tabs = function(config)
    local Tabs = require("lualine.components.tabs")
    local tabs = Tabs(config.options)
    return tabs:update_status()
end

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

return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local lualine = require("lualine")
        lualine.setup({
            inactive_sections = {},
            inactive_winbar = {
                lualine_c = {
                    {
                        Filename,
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
                    {
                        Mode,
                    },
                },
                lualine_b = {},
                lualine_c = {
                    {
                        Filename,
                        path = 1,
                        symbols = {
                            modified = "●",
                        },
                    },
                    {
                        Diagnostics,
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
                    {
                        Filetype,
                    },
                    {
                        Location,
                    },
                },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {
                lualine_b = {
                    {
                        Tabs,
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
                        Filename,
                        color = "lualine_a_insert",
                        symbols = {
                            modified = "●",
                        },
                    },
                    {
                        Spacer,
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
