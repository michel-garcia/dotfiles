return {
    "lukas-reineke/indent-blankline.nvim",
    config = function ()
        local blankline = require("indent_blankline")
        blankline.setup({
            show_current_context = true,
            show_current_context_start = false,
            show_trailing_blankline_indent = false
        })
    end
}

