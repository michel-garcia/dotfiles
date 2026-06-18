vim.pack.add({
    "https://github.com/nvim-mini/mini.statusline",
})

local get_mode_section = function()
    local data = vim.api.nvim_get_mode()
    local names = {
        ["n"] = "NORMAL",
        ["no"] = "O-PENDING",
        ["nov"] = "O-PENDING",
        ["noV"] = "O-PENDING",
        ["no\22"] = "O-PENDING",
        ["niI"] = "NORMAL",
        ["niR"] = "NORMAL",
        ["niV"] = "NORMAL",
        ["nt"] = "NORMAL",
        ["ntT"] = "NORMAL",
        ["v"] = "VISUAL",
        ["vs"] = "VISUAL",
        ["V"] = "V-LINE",
        ["Vs"] = "V-LINE",
        ["\22"] = "V-BLOCK",
        ["\22s"] = "V-BLOCK",
        ["s"] = "SELECT",
        ["S"] = "S-LINE",
        ["\19"] = "S-BLOCK",
        ["i"] = "INSERT",
        ["ic"] = "INSERT",
        ["ix"] = "INSERT",
        ["R"] = "REPLACE",
        ["Rc"] = "REPLACE",
        ["Rx"] = "REPLACE",
        ["Rv"] = "V-REPLACE",
        ["Rvc"] = "V-REPLACE",
        ["Rvx"] = "V-REPLACE",
        ["c"] = "COMMAND",
        ["cv"] = "EX",
        ["ce"] = "EX",
        ["r"] = "REPLACE",
        ["rm"] = "MORE",
        ["r?"] = "CONFIRM",
        ["!"] = "SHELL",
        ["t"] = "TERMINAL",
    }
    local name = names[data.mode] or data.mode
    local groups = {
        ["NORMAL"] = "MiniStatuslineModeNormal",
        ["INSERT"] = "MiniStatuslineModeInsert",
        ["COMMAND"] = "MiniStatuslineModeCommand",
        ["REPLACE"] = "MiniStatuslineModeReplace",
        ["V-REPLACE"] = "MiniStatuslineModeReplace",
        ["VISUAL"] = "MiniStatuslineModeVisual",
        ["V-LINE"] = "MiniStatuslineModeVisual",
        ["V-BLOCK"] = "MiniStatuslineModeVisual",
    }
    local hl = groups[name] or "MiniStatuslineModeOther"
    return {
        hl = hl,
        strings = {
            name,
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
