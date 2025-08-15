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

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover({
                border = "single",
            })
        end, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.jump({
                count = 1,
            })
        end, opts)
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.jump({
                count = -1,
            })
        end, opts)
    end,
    group = vim.api.nvim_create_augroup("LspMappings", {
        clear = true,
    }),
})
