return {
    "luisiacc/gruvbox-baby",
    config = function()
        local colors = require("gruvbox-baby.colors")
        vim.g.gruvbox_baby_highlights = {
            ColorColumn = {
                link = "CursorColumn",
            },
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
            FloatBorder = {
                bg = colors.p.background,
            },
            NormalFloat = {
                bg = colors.p.background,
            },
            WinSeparator = {
                link = "@comment",
            },
        }
        vim.g.gruvbox_baby_transparent_mode = true
        vim.cmd.colorscheme("gruvbox-baby")
    end,
}
