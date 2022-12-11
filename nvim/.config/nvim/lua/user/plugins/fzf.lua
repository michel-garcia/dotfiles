return {
    "ibhagwan/fzf-lua",
    config = function ()
        local fzf = require("fzf-lua")
        fzf.setup({
            files = {
                file_icons = false,
                git_icons = false
            },
            fzf_opts = {
                ["--color"] = "bg+:-1,header:-1",
                ["--info"] = "hidden",
                ["--header"] = string.rep("-", 80 - 4)
            },
            winopts = {
                preview = {
                    hidden = "hidden"
                }
            },
            winopts_fn = function ()
                return {
                    border = "single",
                    col = .5,
                    height = 15,
                    row = .5,
                    width = 80
                }
            end
        })
        local opts = {
            noremap = true,
            silent = true
        }
        vim.keymap.set("n", "<leader>ff", function ()
            fzf.files()
        end, opts)
        vim.keymap.set("n", "<leader>fs", function ()
            fzf.lsp_document_symbols()
        end, opts)
    end
}

