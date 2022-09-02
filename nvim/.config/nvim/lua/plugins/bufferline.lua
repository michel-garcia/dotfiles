return {
    "akinsho/bufferline.nvim",
    requires = {
        "famiu/bufdelete.nvim",
    },
    config = function ()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                always_show_bufferline = true,
                close_command = "Bdelete",
                indicator = {
                    style = "none"
                },
                modified_icon = "",
                offsets = {{
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Normal",
                    text_align = "center"
                }},
                show_buffer_close_icons = false,
                show_buffer_icons = false,
                show_close_icon = false,
                separator_style = "none"
            }
        })
    end
}

