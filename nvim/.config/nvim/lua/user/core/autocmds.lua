local group = vim.api.nvim_create_augroup("AutoCmds", {
    clear = true
})

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function (args)
        local path = vim.fn.fnamemodify(args.file, ":p:h")
        if string.sub(path, 1, string.len("scp")) ~= "scp" then
            vim.fn.mkdir(path, "p")
        end
    end,
    group = group
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function ()
        vim.opt.autoindent = true
        vim.opt.formatoptions = ""
        vim.opt.indentexpr = "return -1"
    end,
    group = group
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function ()
        vim.highlight.on_yank()
    end,
    group = group
})

