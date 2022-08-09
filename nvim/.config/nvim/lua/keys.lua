vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>wv", ":vsplit")
vim.keymap.set("n", "<leader>wh", ":split")

vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>")
