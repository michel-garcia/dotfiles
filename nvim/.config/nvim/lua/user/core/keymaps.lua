vim.keymap.set({ "n", "x" }, "j", function()
    local keys = table.concat({
        vim.v.count > 0 and vim.v.count or "",
        vim.v.count > 0 and "j" or "gj",
    })
    vim.api.nvim_feedkeys(keys, "n", false)
end)
vim.keymap.set({ "n", "x" }, "k", function()
    local keys = table.concat({
        vim.v.count > 0 and vim.v.count or "",
        vim.v.count > 0 and "k" or "gk",
    })
    vim.api.nvim_feedkeys(keys, "n", false)
end)
vim.keymap.set("n", "<C-s>", "<cmd>wincmd s<CR>")
vim.keymap.set("n", "<C-v>", "<cmd>wincmd v<CR>")
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>noh<cr>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
