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

return {
    "glepnir/dashboard-nvim",
    config = function ()
        local dashboard = require("dashboard")
        dashboard.custom_header = get_header_artwork()
        dashboard.custom_center = {{
            desc = "New File",
            action = ":e New File"
        }, {
            desc = "File Browser",
            action = ":Telescope file_browser"
        }, {
            desc = "Find Files",
            action = ":Telescope find_files"
        }, {
            desc = "Quit",
            action = ":q"
        }}
        dashboard.custom_footer = {
            os.date("%Y-%m-%d %H:%M")
        }
    end
}
