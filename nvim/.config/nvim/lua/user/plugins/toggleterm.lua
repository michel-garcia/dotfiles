return {
    "akinsho/toggleterm.nvim",
    config = function ()
        local toggleterm = require("toggleterm")
        toggleterm.setup({
            persist_mode = false,
            shade_terminals = false,
            size = 15
        })
        vim.keymap.set({ "n", "t" }, "<C-\\>", "<Cmd>ToggleTerm<CR>", {
            noremap = true,
            silent = true
        })
        local Terminal = require("toggleterm.terminal").Terminal
        for n = 1, 9 do
            local terminal = Terminal:new({ count = n })
            vim.keymap.set({ "n", "t" }, string.format("<C-%s>", n), function ()
                terminal:toggle()
            end, {
                noremap = true,
                silent = true
            })
        end
    end
}
