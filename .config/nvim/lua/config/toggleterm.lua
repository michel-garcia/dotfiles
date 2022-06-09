return {
    "akinsho/nvim-toggleterm.lua",
    config = function ()
        local toggleterm = require("toggleterm")
        toggleterm.setup({
            open_mapping = "<C-\\>",
            terminal_mappings = true
        })
    end
}

