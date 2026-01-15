return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns")
        gitsigns.setup({
            attach_to_untracked = true,
            linehl = true,
        })
    end,
}
