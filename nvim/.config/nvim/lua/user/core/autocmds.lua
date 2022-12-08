vim.api.nvim_create_autocmd("VimEnter", {
    callback = function (args)
        if vim.fn.isdirectory(args.file) ~= 0 then
            vim.fn.chdir(args.file)
        end
    end,
    group = vim.api.nvim_create_augroup("WorkingDirectory", {
        clear = true
    })
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function ()
        vim.cmd("setlocal formatoptions-=c")
        vim.cmd("setlocal formatoptions-=r")
        vim.cmd("setlocal formatoptions-=o")
    end,
    group = vim.api.nvim_create_augroup("DisableAutoComments", {
        clear = true
    })
})

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function (args)
        local path = vim.fn.fnamemodify(args.file, ":p:h")
        if string.sub(path, 1, string.len("scp")) ~= "scp" then
            vim.fn.mkdir(path, "p")
        end
    end,
    group = vim.api.nvim_create_augroup("AutoMkDirOnWrite", {
        clear = true
    })
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function ()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 1000
        })
    end,
    group = vim.api.nvim_create_augroup("YankHighlight", {
        clear = true
    })
})

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function ()
        vim.api.nvim_win_set_option(0, "cursorline", false)
        vim.api.nvim_win_set_option(0, "number", false)
        vim.api.nvim_win_set_option(0, "relativenumber", false)
        vim.api.nvim_win_set_option(0, "signcolumn", "no")
        vim.cmd("startinsert")
    end,
    group = vim.api.nvim_create_augroup("TerminalOptions", {
        clear = true
    })
})

