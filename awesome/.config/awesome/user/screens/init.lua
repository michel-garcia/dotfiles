local awful = require("awful")
local icons = require("user.theme.icons")

awful.screen.connect_for_each_screen(function (s)
    local normal = s.geometry.width >= s.geometry.height
    for i = 1, 4 do
        awful.tag.add(icons.workspace, {
            layout = awful.layout.layouts[normal and 1 or 2],
            screen = s,
            selected = (i == 1)
        })
    end
end)

