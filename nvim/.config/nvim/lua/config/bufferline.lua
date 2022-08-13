return {
    "akinsho/bufferline.nvim",
    requires = {
        "kyazdani42/nvim-web-devicons"
    },
    config = function ()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                offsets = {{
                    filetype = "NvimTree",
                    text = function ()
                        local ok, tree = pcall(require, "nvim-tree.core")
                        if ok then
                            return tree.get_cwd()
                        end
                        return vim.fn.expand("%:p:h:t")
                    end,
                    highlight = "Directory",
                    text_align = "left"
                }},
                show_buffer_icons = false,
                show_close_icon = false
            }
        })
    end
}

