return {
    "echasnovski/mini.cursorword",
    opts = {
        delay = 0
    },
    config = function (opts)
        local cursorword = require("mini.cursorword")
        cursorword.setup(opts)
        vim.api.nvim_set_hl(0, "MiniCursorword", {
            link = "MatchParen"
        })
    end
}
