return {
    "akinsho/bufferline.nvim",
    requires = {
        "famiu/bufdelete.nvim",
    },
    config = function ()
        local bufferline = require("bufferline")
        bufferline.setup({
            highlights = {
                buffer_selected = {
                    bg = {
                        attribute = "bg",
                        highlight = "Tabline"
                    }
                },
                modified_selected = {
                    bg = {
                        attribute = "bg",
                        highlight = "Tabline"
                    }
                },
                indicator_selected = {
                    bg = {
                        attribute = "bg",
                        highlight = "Tabline"
                    },
                    fg = {
                        attribute = "bg",
                        highlight = "Tabline"
                    }
                }
            },
            options = {
                always_show_bufferline = true,
                close_command = "Bdelete",
                indicator = {
                    style = "none"
                },
                modified_icon = "",
                offsets = {{
                    filetype = "NvimTree",
                    highlight = "Keyword",
                    separator = false,
                    text = function ()
                        local version = vim.version()
                        return table.concat({
                            " NeoVim",
                            table.concat({
                                version.major,
                                version.minor,
                                version.patch
                            }, ".")
                        }, " ")
                    end,
                    text_align = "left"
                }},
                separator_style = { "", "" },
                show_buffer_close_icons = false,
                show_buffer_icons = false,
                show_close_icon = false
            }
        })
    end
}

