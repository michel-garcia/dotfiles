return {
    "akinsho/toggleterm.nvim",
    config = function ()
        local toggleterm = require("toggleterm")
        toggleterm.setup({
            shade_terminals = false,
            size = 15
        })
        vim.keymap.set({ "n", "t" }, "<C-\\>", "<Cmd>ToggleTerm<CR>", {
            noremap = true,
            silent = true
        })
    end
}
