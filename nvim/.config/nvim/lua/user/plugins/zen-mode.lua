return {
    "folke/zen-mode.nvim",
    config = function()
        local zen_mode = require("zen-mode")
        zen_mode.setup()
        vim.keymap.set("n", "<leader>kz", function()
            zen_mode.toggle()
        end)
    end,
}
