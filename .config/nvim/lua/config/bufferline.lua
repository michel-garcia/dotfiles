return {
    "akinsho/bufferline.nvim",
    requires = {
        "moll/vim-bbye"
    },
    config = function ()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                separator_style = "slant",
                mode = "buffers",
                show_buffer_close_icons = false,
                show_buffer_icons = false
            }
        })
        vim.keymap.set("n", "<A-.>", ":BufferLineCycleNext<CR>")
        vim.keymap.set("n", "<A-,>", ":BufferLineCyclePrev<CR>")
        vim.keymap.set("n", "<A-c>", ":Bdelete<CR>")
    end
}

