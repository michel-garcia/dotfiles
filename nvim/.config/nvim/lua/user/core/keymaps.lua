local mappings = {
    general = {
        bind = function (opts)
            vim.keymap.set({ "n", "x" }, "j", function ()
                vim.api.nvim_feedkeys(table.concat({
                    vim.v.count > 0 and vim.v.count or "",
                    vim.v.count > 0 and "j" or "gj"
                }), "n", false)
            end, opts)
            vim.keymap.set({ "n", "x" }, "k", function ()
                vim.api.nvim_feedkeys(table.concat({
                    vim.v.count > 0 and vim.v.count or "",
                    vim.v.count > 0 and "k" or "gk"
                }), "n", false)
            end, opts)
            vim.keymap.set("n", "<C-s>", "<cmd>wincmd s<CR>", opts)
            vim.keymap.set("n", "<C-v>", "<cmd>wincmd v<CR>", opts)
            vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>", opts)
            vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>", opts)
            vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>", opts)
            vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>", opts)
            vim.keymap.set("n", "<C-t>", "<cmd>$tabnew<CR>", opts)
            vim.keymap.set("n", "<C-w>", "<cmd>tabclose<CR>", vim.tbl_extend('force', opts, {
                nowait = true
            }))
            vim.keymap.set("n", "<C-,>", "<cmd>tabprevious<CR>", opts)
            vim.keymap.set("n", "<C-.>", "<cmd>tabnext<CR>", opts)
            vim.keymap.set("v", "<", "<gv", opts)
            vim.keymap.set("v", ">", ">gv", opts)
            vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", opts)
            vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", opts)
            vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
            vim.keymap.set("t", "<A-h>", "<C-\\><C-n><cmd>wincmd h<CR>", opts)
            vim.keymap.set("t", "<A-j>", "<C-\\><C-n><cmd>wincmd j<CR>", opts)
            vim.keymap.set("t", "<A-k>", "<C-\\><C-n><cmd>wincmd k<CR>", opts)
            vim.keymap.set("t", "<A-l>", "<C-\\><C-n><cmd>wincmd l<CR>", opts)
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

