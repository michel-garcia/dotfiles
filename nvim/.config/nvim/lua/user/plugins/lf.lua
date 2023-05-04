return {
    "lmburns/lf.nvim",
    dependencies = {
        "akinsho/toggleterm.nvim",
        "nvim-lua/plenary.nvim"
    },
    config = function ()
        local lf = require("lf")
        lf.setup({
            border = "single",
            height = .5,
            width = .5,
            winblend = 0
        })
        vim.keymap.set("n", "<leader>e", ":Lf<CR>", {
            noremap = true,
            silent = true
        })
    end
}

