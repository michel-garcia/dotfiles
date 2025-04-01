local map = function(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("force", {
        noremap = true,
        silent = true,
    }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

map({ "n", "x" }, "j", function()
    local keys = table.concat({
        vim.v.count > 0 and vim.v.count or "",
        vim.v.count > 0 and "j" or "gj",
    })
    vim.api.nvim_feedkeys(keys, "n", false)
end)
map({ "n", "x" }, "k", function()
    local keys = table.concat({
        vim.v.count > 0 and vim.v.count or "",
        vim.v.count > 0 and "k" or "gk",
    })
    vim.api.nvim_feedkeys(keys, "n", false)
end)
map("n", "<C-s>", "<cmd>wincmd s<CR>")
map("n", "<C-v>", "<cmd>wincmd v<CR>")
map("n", "<C-h>", "<cmd>wincmd h<CR>")
map("n", "<C-j>", "<cmd>wincmd j<CR>")
map("n", "<C-k>", "<cmd>wincmd k<CR>")
map("n", "<C-l>", "<cmd>wincmd l<CR>")
map("n", "<C-t>", "<cmd>$tabnew<CR>")
map("n", "<C-w>", "<cmd>tabclose<CR>", { nowait = true })
map("n", "<C-,>", "<cmd>tabprevious<CR>")
map("n", "<C-.>", "<cmd>tabnext<CR>")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "<A-j>", ":move '>+1<CR>gv=gv")
map("v", "<A-k>", ":move '<-2<CR>gv=gv")
map("t", "<Esc>", "<C-\\><C-n>")
map("t", "<A-h>", "<C-\\><C-n><cmd>wincmd h<CR>")
map("t", "<A-j>", "<C-\\><C-n><cmd>wincmd j<CR>")
map("t", "<A-k>", "<C-\\><C-n><cmd>wincmd k<CR>")
map("t", "<A-l>", "<C-\\><C-n><cmd>wincmd l<CR>")

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local opts = {
            buffer = args.buf,
        }
        map("n", "gD", vim.lsp.buf.declaration, opts)
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "K", function()
            vim.lsp.buf.hover({
                border = "single",
            })
        end, opts)
        map("n", "gi", vim.lsp.buf.implementation, opts)
        map("n", "<F2>", vim.lsp.buf.rename, opts)
        map("n", "<F4>", vim.lsp.buf.code_action, opts)
        map("n", "gr", vim.lsp.buf.references, opts)
        map("n", "gl", vim.diagnostic.open_float, opts)
        map("n", "[d", function()
            vim.diagnostic.jump({
                count = 1,
            })
        end, opts)
        map("n", "]d", function()
            vim.diagnostic.jump({
                count = -1,
            })
        end, opts)
    end,
    group = vim.api.nvim_create_augroup("LspMappings", {
        clear = true,
    }),
})
