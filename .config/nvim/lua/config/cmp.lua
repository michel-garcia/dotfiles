return {
    "hrsh7th/nvim-cmp",
    requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "mortepau/codicons.nvim",
        "onsails/lspkind-nvim"
    },
    config = function ()
        local cmp = require("cmp")
        cmp.setup({
            formatting = {
                format = require("lspkind").cmp_format({
                    mode = "symbol",
                    preset = "codicons"
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
    end
}

