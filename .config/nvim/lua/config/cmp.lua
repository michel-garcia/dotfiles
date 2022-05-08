local cmp = require("cmp")

cmp.setup({
    formatting = {
        format = require("lspkind").cmp_format({
            mode = "symbol"
        })
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-q>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        })
    },
    sources = {
        { name = "nvim_buffer" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "nvim_path" },
        { name = "nvim_lsp_signature_help" }
    }
})
