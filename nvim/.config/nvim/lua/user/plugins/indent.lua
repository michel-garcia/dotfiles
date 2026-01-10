return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        local indent = require("ibl")
        indent.setup({
            scope = {
                show_end = false,
                show_start = false,
            },
        })
    end,
}
