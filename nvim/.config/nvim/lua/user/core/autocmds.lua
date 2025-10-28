local group = vim.api.nvim_create_augroup("AutoCmds", {
    clear = true,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(args)
        local path = vim.fn.fnamemodify(args.file, ":p:h")
        if string.sub(path, 1, string.len("scp")) ~= "scp" then
            vim.fn.mkdir(path, "p")
        end
    end,
    group = group,
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.opt.autoindent = true
        vim.opt.formatoptions = ""
        vim.opt.indentexpr = "return -1"
    end,
    group = group,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = group,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local opts = { buffer = args.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover({
                border = "solid",
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
    group = group,
})
