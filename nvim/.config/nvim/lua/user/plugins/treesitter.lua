return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                if vim.fn.empty(args.match) == 1 then
                    return
                end
                local lang = vim.treesitter.language.get_lang(args.match)
                if not lang then
                    return
                end
                local parsers = require("nvim-treesitter.parsers")
                local available = vim.tbl_keys(parsers)
                if not vim.tbl_contains(available, lang) then
                    return
                end
                if vim.treesitter.language.add(args.match) then
                    vim.treesitter.start(args.buf, lang)
                    return
                end
                local treesitter = require("nvim-treesitter")
                treesitter.install(lang):await(function()
                    vim.treesitter.start(args.buf, lang)
                end)
            end,
            group = vim.api.nvim_create_augroup("TreesitterSetup", {
                clear = true,
            }),
        })
    end,
}
