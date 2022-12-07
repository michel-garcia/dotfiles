return {
    "luisiacc/gruvbox-baby",
    config = function ()
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function ()
                vim.cmd("hi lualine_c_inactive none")
                vim.cmd("hi link lualine_c_inactive lualine_c_normal")
            end,
            group = vim.api.nvim_create_augroup("CustomHighlightingGroups", {
                clear = true
            })
        })
        vim.cmd("colorscheme gruvbox-baby")
    end
}

