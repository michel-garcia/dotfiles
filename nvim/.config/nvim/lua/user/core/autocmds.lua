local group = vim.api.nvim_create_augroup("CustomAutocommands", {
    clear = true
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function (args)
        if vim.fn.isdirectory(args.file) ~= 0 then
            vim.opt.hidden = false
            vim.cmd.chdir(args.file)
        end
    end,
    group = group
})

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function ()
        vim.opt.hidden = true
    end,
    group = group
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

vim.api.nvim_create_autocmd("OptionSet", {
    pattern = "tabline",
    callback = function (args)
        vim.opt.showtabline = 1
    end,
    group = group
})

vim.api.nvim_create_autocmd("TermEnter", {
    callback = function ()
        vim.fn.clearmatches()
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
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 700
        })
    end,
    group = group
})

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function ()
        vim.api.nvim_win_set_option(0, "cursorline", false)
        vim.api.nvim_win_set_option(0, "number", false)
        vim.api.nvim_win_set_option(0, "relativenumber", false)
        vim.api.nvim_win_set_option(0, "signcolumn", "no")
        vim.cmd("startinsert")
    end,
    group = group
})

