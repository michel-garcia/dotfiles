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

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost", "FileType", "LspAttach" }, {
    callback = function()
        vim.schedule(function()
            vim.opt.autoindent = true
            vim.opt.formatoptions = ""
            vim.opt.indentexpr = function ()
                return -1
            end
        end)
    end,
    group = group,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = group,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "CursorHold", "WinEnter" }, {
    callback = function()
        local current = vim.api.nvim_get_current_win()
        local wins = vim.api.nvim_tabpage_list_wins(0)
        for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            local buftype = vim.api.nvim_get_option_value("buftype", {
                buf = buf,
            })
            if buftype == "" then
                if win == current then
                    vim.wo[win].winbar = "%#WinBarTitle# %t %m %*"
                else
                    vim.wo[win].winbar = "%#WinBarTitleNC# %t %m %*"
                end
            end
        end
    end,
    group = group,
})
