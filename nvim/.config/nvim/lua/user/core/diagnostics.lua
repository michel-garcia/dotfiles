local signs = {
    [vim.diagnostic.severity.ERROR] = "",
    [vim.diagnostic.severity.WARN] = "",
    [vim.diagnostic.severity.INFO] = "",
    [vim.diagnostic.severity.HINT] = "",
}

vim.diagnostic.config({
    severity_sort = true,
    signs = {
        linehl = {
            [vim.diagnostic.severity.ERROR] = "Error",
            [vim.diagnostic.severity.WARN] = "Warn",
            [vim.diagnostic.severity.INFO] = "Info",
            [vim.diagnostic.severity.HINT] = "Hint",
        },
        text = signs,
    },
    underline = true,
    update_in_insert = true,
    virtual_text = {
        format = function(diagnostic)
            return table.concat({
                signs[diagnostic.severity] or "",
                diagnostic.message,
            }, " ")
        end,
        prefix = "",
    },
})
