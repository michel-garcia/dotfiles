local awful = require("awful")

awful.screen.connect_for_each_screen(function (s)
    if s.geometry.width >= s.geometry.height then
        for i = 1, 4 do
            awful.tag.add("", {
                layout = awful.layout.layouts[1],
                screen = s,
                selected = (i == 1)
            })
        end
    else
        awful.tag.add("*", {
            column_count = 4,
            layout = awful.layout.layouts[2],
            master_count = 0,
            screen = s,
            selected = true
        })
    end
end)

