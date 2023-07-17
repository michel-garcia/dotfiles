return {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
        "ibhagwan/fzf-lua"
    },
    config = function ()
        local neoclip = require("neoclip")
        neoclip.setup({
            default_register = { "\"", "+", "*" },
            keys = {
                fzf = {
                    paste = "",
                    paste_behind = ""
                }
            }
        })
        local fzf = require("fzf-lua")
        fzf.clipboard = function ()
            local clipboard = require("neoclip.fzf")
            clipboard()
        end
        vim.keymap.set("n", "<leader>c", function ()
            fzf.clipboard()
        end, { noremap = true, silent = true })
    end
}
