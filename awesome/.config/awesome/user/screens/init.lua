local awful = require("awful")
local icons = require("user.theme.icons")

awful.screen.connect_for_each_screen(function (s)
    local rotated = s.geometry.width < s.geometry.height
    local normal_layout = awful.layout.suit.tile
    local vertical_layout = normal_layout.bottom
    for i = 1, 4 do
        awful.tag.add(icons.workspace, {
            column_count = not rotated and 1 or 4,
            layout = not rotated and normal_layout or vertical_layout,
            master_count = not rotated and 1 or 0,
            screen = s,
            selected = (i == 1)
        })
    end
end)

