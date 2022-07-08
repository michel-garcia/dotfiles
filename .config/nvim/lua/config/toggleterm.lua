return {
    "akinsho/nvim-toggleterm.lua",
    config = function ()
        local toggleterm = require("toggleterm")
        toggleterm.setup({
            direction = "float",
            float_opts = {
                border = "curved"
            },
            open_mapping = "<C-\\>",
            terminal_mappings = true
        })
    end
}
