return {
    "rachartier/tiny-inline-diagnostic.nvim",
    config = function()
        local diagnostic = require("tiny-inline-diagnostic")
        diagnostic.setup({
            options = {
                add_messages = {
                    use_max_severity = true,
                },
                multilines = {
                    enabled = true,
                },
                use_icons_from_diagnostic = true,
            },
            preset = "classic",
            transparent_bg = true,
        })
        vim.diagnostic.config({
            virtual_text = false,
        })
    end,
}
