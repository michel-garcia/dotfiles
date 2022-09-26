return {
    "akinsho/bufferline.nvim",
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
                indicator_selected = {
                    bg = {
                        attribute = "bg",
                        highlight = "Tabline"
                    },
                    fg = {
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
                separator = {
                    fg = {
                        attribute = "bg",
                        highlight = "Tabline"
                    }
                },
                separator_selected = {
                    fg = {
                        attribute = "bg",
                        highlight = "Tabline"
                    }
                }
            },
            options = {
                mode = "tabs",
                name_formatter = function (buffer)
                    if string.len(buffer.name) > 0 then
                        return buffer.name
                    else
                        return vim.api.nvim_buf_get_option(
                            buffer.bufnr or 0,
                            "filetype"
                        )
                    end
                end,
                show_buffer_close_icons = false,
                show_buffer_icons = false,
                show_close_icon = false
            }
        })
    end
}

