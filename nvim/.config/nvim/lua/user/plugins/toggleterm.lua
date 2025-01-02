return {
    "akinsho/toggleterm.nvim",
    config = function ()
        local toggleterm = require("toggleterm")
        toggleterm.setup({
            persist_mode = false,
            size = 15
        })
        vim.keymap.set({ "n", "t" }, "<C-\\>", "<Cmd>ToggleTerm<CR>", {
            noremap = true,
            silent = true
        })
        for i = 1, 9 do
            vim.keymap.set({ "n", "t" }, string.format("<C-%s>", i), function ()
                toggleterm.toggle(i)
            end, {
                noremap = true,
                silent = true
            })
        end
    end
}
