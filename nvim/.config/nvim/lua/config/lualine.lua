return {
    "nvim-lualine/lualine.nvim",
    config = function ()
        local lualine = require("lualine")
        lualine.setup({
            options = {
                component_separators = "│",
                icons_enabled = false,
                section_separators = ""
            }
        })
    end
}

