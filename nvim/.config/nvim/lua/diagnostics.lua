vim.diagnostic.config({
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
            local signs = vim.fn.sign_getdefined(name)
            local sign = signs[1]
            if not sign then
                return diagnostic.message
            end
            return string.format(
                "%s %s",
                sign.text,
                diagnostic.message
            )
        end,
        prefix = ""
    }
})
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

