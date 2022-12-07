return {
    "gelguy/wilder.nvim",
    config = function ()
        local wilder = require("wilder")
        wilder.setup({
            modes = { ":", "/" }
        })
        local renderer = wilder.wildmenu_renderer()
        wilder.set_option("renderer", renderer)
    end
}

