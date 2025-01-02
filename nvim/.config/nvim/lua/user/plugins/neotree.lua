return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function(_, opts)
        local neotree = require("neo-tree")
        neotree.setup(opts)
        vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", {
            noremap = true,
            silent = true,
        })
    end,
    opts = {
        popup_border_style = "single",
    },
}
