function get_header_artwork()
    local filename = vim.fn.expand("~/.config/nvim/artwork.txt")
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

function Button(caption, action)
    return {
        type = "button",
        val = caption,
        on_press = function ()
            vim.cmd(action)
        end,
        opts = {
            position = "center",
            shortcut = " ",
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
                val = get_header_artwork() or "Neovim",
                opts = {
                    position = "center"
                }
            }, {
                type = "padding",
                val = 2
            }, {
                type = "group",
                val = {
                    Button("New File", ":e New File"),
                    Button("File Browser", ":Telescope file_browser"),
                    Button("Find Files", ":Telescope find_files"),
                    Button("Quit", ":qa")
                },
                opts = {
                    spacing = 1
                }
            }, {
                type = "text",
                val = os.date("%Y-%M-%d %H:%m"),
                opts = {
                    position = "center"
                }
            }},
            opts = {
                margin = 6
            }
        })
    end
}
