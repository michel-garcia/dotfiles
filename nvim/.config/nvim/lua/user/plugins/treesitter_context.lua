return {
    "nvim-treesitter/nvim-treesitter-context",
    requires = {
        "nvim-treesitter/nvim-treesitter"
    },
    config = function ()
        local treesitter_context = require("treesitter-context")
        treesitter_context.setup({
            enable = true
        })
    end
}

