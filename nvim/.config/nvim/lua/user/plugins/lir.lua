return {
    "tamago324/lir.nvim",
    config = function ()
        local lir = require("lir")
        local actions = require("lir.actions")
        lir.setup({
            float = {
                win_opts = function ()
                    return {
                        border = vim.g.borders.frame,
                        col = (vim.o.columns - 80) / 2,
                        height = 15,
                        row = (vim.o.lines - 15) / 2,
                        width = 80
                    }
                end
            },
            hide_cursor = true,
            mappings = {
                ["<CR>"] = actions.edit,
                ["l"] = actions.edit,
                ["h"] = actions.up,
                ["<C-s>"] = actions.split,
                ["<C-v>"] = actions.vsplit,
                ["<C-t>"] = actions.tabedit,
                ["<C-c>"] = actions.quit,
                ["<Esc>"] = actions.quit,
                ["q"] = actions.quit,
                ["%"] = actions.touch,
                ["d"] = actions.mkdir,
                ["x"] = actions.cut,
                ["y"] = actions.copy,
                ["p"] = actions.paste,
                ["R"] = actions.rename,
                ["D"] = actions.delete
            },
            show_hidden_files = true
        })
        vim.api.nvim_set_hl(0, "LirFloatNormal", {
            link = "NormalFloat"
        })
        vim.api.nvim_set_hl(0, "LirFloatCurdirWindowNormal", {
            link = "NormalFloat"
        })
        vim.keymap.set("n", "<leader>e", function ()
            local float = require("lir.float")
            float.init()
        end, { noremap = true, silent = true })
    end
}
