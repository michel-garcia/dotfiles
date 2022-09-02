return {
    "numToStr/FTerm.nvim",
    config = function ()
        local fterm = require("FTerm")
        fterm.setup({
            border = "single"
        })
    end
}

