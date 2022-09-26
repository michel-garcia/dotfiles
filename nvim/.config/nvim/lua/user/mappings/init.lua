local opts = {
    noremap = true,
    silent = true
}
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<Tab>", ":tabn<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":tabp<CR>", opts)
vim.keymap.set("n", "<A-t>", ":$tabnew<CR>:terminal<CR>", opts)
vim.keymap.set("n", "<A-c>", ":tabclose<CR>", opts)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
vim.keymap.set("t", "<Tab>", "<C-\\><C-n>:tabn<CR>", opts)
vim.keymap.set("t", "<S-Tab>", "<C-\\><C-n>:tabp<CR>", opts)
vim.keymap.set("t", "<A-t>", "<C-\\><C-n>:$tabnew<CR>:terminal<CR>", opts)
vim.keymap.set("t", "<A-c>", "<C-\\><C-n>:tabclose<CR>", opts)

