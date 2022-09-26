return {
    "navarasu/onedark.nvim",
    config = function ()
        local onedark = require("onedark")
        onedark.setup({
            style = "deep",
            transparent = true
        })
        onedark.load()
    end
}

