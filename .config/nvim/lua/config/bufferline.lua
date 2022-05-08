local bufferline = require("bufferline")

bufferline.setup({
    options = {
        mode = "buffers"
    }
})

vim.keymap.set("n", "<A-.>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<A-,>", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<A-c>", ":bdelete<CR>")
