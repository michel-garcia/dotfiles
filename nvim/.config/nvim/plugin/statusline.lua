vim.pack.add({
    "https://github.com/nvim-mini/mini.statusline",
})

local get_mode_section = function()
    local statusline = require("mini.statusline")
    local name, hl = statusline.section_mode({
        trunc_width = 64,
    })
    return {
        hl = hl,
        strings = {
            string.upper(name),
        },
    }
end

local get_filename_section = function()
    local buftype = vim.api.nvim_get_option_value("buftype", {
        buf = 0,
    })
    local filename = buftype ~= "terminal" and "%f%m %r" or "%t"
    return {
        hl = "MiniStatuslineFilename",
        strings = {
            filename,
        },
    }
end

local get_filetype_section = function()
    local buftype = vim.api.nvim_get_option_value("buftype", {
        buf = 0,
    })
    if buftype == "terminal" then
        return {}
    end
    local filetype = vim.api.nvim_get_option_value("filetype", {
        buf = 0,
    })
    if filetype == "" then
        return {}
    end
    local _, icons = pcall(require, "mini.icons")
    if icons then
        local icon = icons.get("filetype", filetype)
        filetype = table.concat({
            icon,
            filetype,
        }, "  ")
    end
    return {
        hl = "MiniStatuslineFiletype",
        strings = {
            filetype,
        },
    }
end

local get_location_section = function()
    local buftype = vim.api.nvim_get_option_value("buftype", {
        buf = 0,
    })
    if buftype == "terminal" then
        return {}
    end
    local location = table.concat({
        vim.fn.line("."),
        vim.fn.col("."),
    }, ":")
    return {
        hl = "MiniStatuslineLocation",
        strings = {
            location,
        },
    }
end

local statusline = require("mini.statusline")
statusline.setup({
    content = {
        active = function()
            return statusline.combine_groups({
                get_mode_section(),
                "%<",
                get_filename_section(),
                "%=",
                get_filetype_section(),
                get_location_section(),
            })
        end,
    },
})
