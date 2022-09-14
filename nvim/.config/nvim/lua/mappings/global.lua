return {
    bind = function ()
        vim.keymap.set("v", "<", "<gv")
        vim.keymap.set("v", ">", ">gv")
        vim.keymap.set("n", "<leader>wv", ":vsplit<CR>")
        vim.keymap.set("n", "<leader>wh", ":split<CR>")
        vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
        vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
        vim.keymap.set("n", "<leader>x", ":Bdelete<CR>")
        vim.keymap.set("n", "<leader>f", vim.diagnostic.open_float)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
        vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>")
        vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>")
        vim.keymap.set("n", "<Bslash>", ":Telescope buffers<CR>")
        vim.keymap.set("n", "<C-j>", function ()
            local rest = require("rest-nvim")
            rest.run()
        end)
        vim.keymap.set("n", "<A-t>", function ()
            vim.cmd("ToggleTerm")
        end)
        vim.keymap.set("t", "<A-t>", function ()
            vim.api.nvim_feedkeys("<C-\\>", "n", true)
            vim.api.nvim_feedkeys("<C-n>", "n", true)
            vim.cmd("ToggleTerm")
        end)
    end
}

