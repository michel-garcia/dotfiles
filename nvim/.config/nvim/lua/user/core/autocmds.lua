local group = vim.api.nvim_create_augroup("CustomAutocommands", {
    clear = true
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function (args)
        if vim.fn.isdirectory(args.file) ~= 0 then
            vim.cmd.chdir(args.file)
        end
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

vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function (args)
        local saved = not vim.api.nvim_buf_get_option(args.buf, "modified")
        if saved then
            vim.notify("Saved successfully!")
        else
            local message = string.format("Failed to save '%s'", args.file)
            vim.notify(message, "error")
        end
    end,
    group = group
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function ()
        vim.bo.formatoptions = vim.bo.formatoptions:gsub("[cro]", "")
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

