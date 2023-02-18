return {
    "folke/zen-mode.nvim",
    config = function ()
        local zen_mode = require("zen-mode")
        zen_mode.setup()
        local opts = {
            noremap = true,
            silent = true
        }
        vim.keymap.set("n", "<leader>kz", function ()
            zen_mode.toggle()
        end, opts)
    end
}

