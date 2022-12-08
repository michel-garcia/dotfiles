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

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function ()
        vim.cmd("hi lualine_c_inactive none")
        vim.cmd("hi link lualine_c_inactive lualine_c_normal")
        vim.cmd("hi DashboardHeader none")
        vim.cmd("hi link DashboardHeader @type")
        vim.cmd("hi DashboardFooter none")
        vim.cmd("hi link DashboardFooter @variable")
    end,
    group = vim.api.nvim_create_augroup("CustomHighlights", {
        clear = true
    })
})

