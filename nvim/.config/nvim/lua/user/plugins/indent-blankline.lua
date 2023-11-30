return {
    "lukas-reineke/indent-blankline.nvim",
    config = function ()
        local blankline = require("ibl")
        blankline.setup({
            scope = {
                enabled = true,
                show_end = false,
                show_start = false
            }
        })
    end
}

