function get_header_artwork()
    local filename = string.format(
        "%s/artwork.txt",
        vim.fn.stdpath("config")
    )
    local file = io.open(filename)
    if file then
        local lines = {}
        for line in file:lines() do
            table.insert(lines, line)
        end
        file:close()
        return lines
    end
end

function Button(caption, action, shortcut)
    return {
        type = "button",
        val = caption,
        on_press = function ()
            vim.cmd(action)
        end,
        opts = {
            align_shortcut = "right",
            cursor = 5,
            hl_shortcut = "Keyword",
            position = "center",
            shortcut = shortcut,
            width = 50
        }
    }
end

return {
    "goolord/alpha-nvim",
    config = function ()
        local alpha = require("alpha")
        alpha.setup({
            layout = {{
                type = "padding",
                val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * .3) })
            }, {
                type = "text",
                val = get_header_artwork() or "NEOVIM",
                opts = {
                    hl = "String",
                    position = "center"
                }
            }, {
                type = "padding",
                val = 2
            }, {
                type = "group",
                val = {
                    Button(
                        "  New File",
                        ":enew",
                        "<leader>fn"
                    ),
                    Button(
                        "  Recent Files",
                        ":Telescope oldfiles",
                        "<leader>fr"
                    ),
                    Button(
                        "  Bookmarks",
                        ":Telescope marks",
                        "<leader>fm"
                    ),
                    Button(
                        "  File Browser",
                        ":Telescope file_browser",
                        "<leader>fb"
                    ),
                    Button(
                        "  Find Files",
                        ":Telescope find_files",
                        "<leader>ff"
                    ),
                    Button(
                        "  Options",
                        ":Telescope vim_options",
                        "<leader>fo"
                    ),
                    Button(
                        "  Extensions",
                        ":PackerStatus",
                        "<leader>ps"
                    ),
                    Button(
                        "  Quit",
                        ":qa",
                        ""
                    )
                },
                opts = {
                    spacing = 1
                }
            }, {
                type = "text",
                val = os.date("%Y-%M-%d %H:%m"),
                opts = {
                    hl = "Special",
                    position = "center"
                }
            }},
            opts = {
                margin = 6
            }
        })
    end
}
