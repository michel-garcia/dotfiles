return {
    "rest-nvim/rest.nvim",
    requires = {
        "nvim-lua/plenary.nvim"
    },
    config = function ()
        local rest = require("rest-nvim")
        rest.setup()
    end
}

