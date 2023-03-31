return {
    "luisiacc/gruvbox-baby",
    config = function ()
        vim.g.gruvbox_baby_transparent_mode = true
        vim.cmd.colorscheme("gruvbox-baby")
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
            sp = "red",
            undercurl = true
        })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {
            sp = "orange",
            undercurl = true
        })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {
            sp = "lightblue",
            undercurl = true
        })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {
            sp = "lightgray",
            undercurl = true
        })
    end
}

