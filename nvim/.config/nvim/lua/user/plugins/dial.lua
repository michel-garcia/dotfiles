return {
    "monaqa/dial.nvim",
    config = function()
        local config = require("dial.config")
        local augend = require("dial.augend")
        config.augends:register_group({
            default = {
                augend.integer.alias.decimal_int,
                augend.integer.alias.binary,
                augend.integer.alias.octal,
                augend.integer.alias.hex,
                augend.constant.alias.alpha,
                augend.constant.alias.Alpha,
                augend.constant.alias.bool,
            },
        })
        local map = require("dial.map")
        vim.keymap.set("n", "<C-a>", map.inc_normal())
        vim.keymap.set("n", "<C-x>", map.dec_normal())
        vim.keymap.set("v", "<C-a>", map.inc_visual())
        vim.keymap.set("v", "<C-x>", map.dec_visual())
    end,
}
