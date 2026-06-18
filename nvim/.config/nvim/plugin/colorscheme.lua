vim.pack.add({
    "https://github.com/luisiacc/gruvbox-baby",
})

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
    StatusLine = {
        bg = "none",
    },
    StatusLineNC = {
        bg = "none",
    },
    StatusLineTerm = {
        bg = "none",
    },
    WinSeparator = {
        link = "@comment",
    },
}
vim.g.gruvbox_baby_transparent_mode = true
vim.cmd.colorscheme("gruvbox-baby")
