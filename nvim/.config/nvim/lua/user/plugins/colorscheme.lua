return {
    "luisiacc/gruvbox-baby",
    priority = 1000,
    config = function()
        vim.g.gruvbox_baby_highlights = {
            DiagnosticUnderlineError = {
                sp = "red",
                style = "undercurl",
            },
            DiagnosticUnderlineWarn = {
                sp = "orange",
                style = "undercurl",
            },
            DiagnosticUnderlineInfo = {
                sp = "lightblue",
                style = "undercurl",
            },
            DiagnosticUnderlineHint = {
                sp = "lightgray",
                style = "undercurl",
            },
            WinSeparator = {
                link = "@comment",
            },
        }
        vim.g.gruvbox_baby_transparent_mode = true
        vim.cmd.colorscheme("gruvbox-baby")
    end,
}
