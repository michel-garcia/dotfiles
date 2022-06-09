return {
    "nvim-treesitter/nvim-treesitter",
    requires = {
        "windwp/nvim-ts-autotag"
    },
    run = ":TSUpdate",
    config = function ()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            autotag = { enable = true },
            ensure_installed = "all",
            highlight = { enable = true },
            indent = { enable = false }
        })
    end
}

