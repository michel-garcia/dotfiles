return {
    "folke/tokyonight.nvim",
    requires = {
        "xiyaowong/nvim-transparent"
    },
    config = function ()
        vim.cmd("colorscheme tokyonight")
        local transparent = require("transparent")
        transparent.setup({
            enable = true
        })
        vim.api.nvim_set_hl(0, "NvimTreeNormal", {
            bg = "none"
        })
        vim.api.nvim_set_hl(0, "NvimTreeNormalNC", {
            bg = "none"
        })
    end
}

