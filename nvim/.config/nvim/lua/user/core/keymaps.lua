local mappings = {
    general = {
        bind = function (opts)
            vim.keymap.set("v", "<", "<gv", opts)
            vim.keymap.set("v", ">", ">gv", opts)
            vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", opts)
            vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", opts)
            vim.keymap.set("n", "<C-s>", "<C-w>s", opts)
            vim.keymap.set("n", "<C-v>", "<C-w>v", opts)
            vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
            vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
            vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
            vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
            vim.keymap.set("t", "<C-w>", "<C-\\><C-n>", opts)
            vim.keymap.set("n", "<A-Tab>", ":tabnext<CR>", opts)
            vim.keymap.set("n", "<A-S-Tab>", ":tabprevious<CR>", opts)
            vim.keymap.set("n", "<A-t>", ":tabnew<CR>", opts)
            vim.keymap.set("n", "<A-\\>", ":tabnew<CR>:terminal<CR>", opts)
            vim.keymap.set("n", "<A-q>", ":tabclose<CR>", opts)
        end
    },
    lsp = {
        bind = function (opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
        end
    }
}

mappings.general.bind({
    noremap = true,
    silent = true
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function (args)
        mappings.lsp.bind({
            buffer = args.buf,
            noremap = true,
            silent = true
        })
    end,
    group = vim.api.nvim_create_augroup("LspMappings", {
        clear = true
    })
})

