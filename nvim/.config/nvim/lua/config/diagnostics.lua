local signs = {
    DiagnosticSignError = "",
    DiagnosticSignWarn = "",
    DiagnosticSignInfo = "",
    DiagnosticSignHint = ""
}
for type, icon in pairs(signs) do
    vim.fn.sign_define(type, {
        numhl = type,
        text = icon,
        texthl = type
    })
end

vim.diagnostic.config({
    float = {
        border = "single",
        style = "minimal"
    },
    severity_sort = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    virtual_text = {
        format = function (diagnostic)
            local names = {
                "DiagnosticSignError",
                "DiagnosticSignWarn",
                "DiagnosticSignInfo",
                "DiagnosticSignHint"
            }
            local name = names[diagnostic.severity]
            local defined = vim.fn.sign_getdefined(name)
            local sign = defined[1]
            if not sign then
                return diagnostic.message
            end
            return table.concat({
                sign.text,
                diagnostic.message
            }, " ")
        end,
        prefix = ""
    }
})
for type, icon in pairs(signs) do
    vim.fn.sign_define(type, {
        numhl = type,
        text = icon,
        texthl = type
    })
end

