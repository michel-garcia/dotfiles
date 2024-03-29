local signs = {
    DiagnosticSignError = "",
    DiagnosticSignWarn = "",
    DiagnosticSignInfo = "",
    DiagnosticSignHint = ""
}

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
            local sign = vim.fn.sign_getdefined(name)[1]
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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = "solid"
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = "solid"
    }
)

