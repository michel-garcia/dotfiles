vim.api.nvim_create_user_command("ReloadConfig", function ()
    for name, _ in pairs(package.loaded) do
        if string.sub(name, 0, string.len("user")) == "user" then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    print("Configuration reloaded!")
end, {})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function ()
        local arg = vim.v.argv[2]
        if arg and vim.fn.isdirectory(arg) == 1 then
            vim.cmd(string.format("cd %s", arg))
        end
    end,
    group = vim.api.nvim_create_augroup("ProjectDirectory", {
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
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "NormalFloat" })
        vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "NormalFloat" })
        vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link = "FloatBorder" })
    end,
    group = vim.api.nvim_create_augroup("Highlights", {
        clear = true
    })
})

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function (args)
        local path = vim.fn.fnamemodify(args.file, ":p:h")
        vim.fn.mkdir(path, "p")
    end,
    group = vim.api.nvim_create_augroup("AutoMkDirOnWrite", {
        clear = true
    })
})

