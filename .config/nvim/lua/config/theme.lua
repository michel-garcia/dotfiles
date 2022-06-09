return {
    "Shatur/neovim-ayu",
    config = function ()
        local ayu = require("ayu")
        ayu.setup({})
        ayu.colorscheme()
    end
}
