return {
    "monaqa/dial.nvim",
    config = function ()
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
                augend.constant.alias.bool
            }
        })
        local map = require("dial.map")
        local opts = {
            noremap = true,
            silent = true
        }
        vim.keymap.set("n", "<C-a>", map.inc_normal(), opts)
        vim.keymap.set("n", "<C-x>", map.dec_normal(), opts)
        vim.keymap.set("v", "<C-a>", map.inc_visual(), opts)
        vim.keymap.set("v", "<C-x>", map.dec_visual(), opts)
    end
}

