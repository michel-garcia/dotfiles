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
                })
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping(function (fallback)
                    if cmp.visible() and cmp.get_selected_entry() then
                        cmp.complete()
                        cmp.close()
                    else
                        fallback()
                    end
                end)
            }),
            sources = cmp.config.sources({
                { name = "nvim_buffer" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "nvim_path" },
                { name = "nvim_lsp_signature_help" }
            })
        })
    end
}

