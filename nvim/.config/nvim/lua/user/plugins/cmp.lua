return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "mortepau/codicons.nvim",
        "onsails/lspkind-nvim"
    },
    config = function ()
        local cmp = require("cmp")
        cmp.setup({
            formatting = {
                format = require("lspkind").cmp_format({
                    mode = "symbol"
                })
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({
                    select = false
                })
            }),
            preselect = cmp.PreselectMode.None,
            snippet = {
                expand = function (args)
                    local luasnip = require("luasnip")
                    luasnip.lsp_expand(args.body)
                end
            },
            sources = cmp.config.sources({
                { name = "nvim_buffer" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "nvim_path" },
                { name = "nvim_lsp_signature_help" }
            }),
            window = {
                completion = {
                    border = "solid",
                    winhighlight = "Normal:NormalFloat"
                },
                documentation = {
                    border = "solid"
                }
            }
        })
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            matching = {
                disallow_symbol_nonprefix_matching = false
            },
            sources = cmp.config.sources({
                { name = "path" }
            }, {
                { name = "cmdline" }
            })
        })
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "buffer" }
            })
        })
    end
}

