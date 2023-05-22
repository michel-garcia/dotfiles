local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")

awful.screen.connect_for_each_screen(function (s)
    local rotated = s.geometry.width < s.geometry.height
    local normal_layout = awful.layout.suit.tile
    local vertical_layout = normal_layout.bottom
    for i = 1, 9 do
        awful.tag.add("\u{F0765}", {
            column_count = not rotated and 1 or 4,
            layout = not rotated and normal_layout or vertical_layout,
            master_count = not rotated and 1 or 0,
            screen = s,
            selected = (i == 1)
        })
    end
end)

screen.connect_signal("property::geometry", function ()
    awesome.restart()
end)

client.connect_signal("manage", function (c)
    if not awesome.startup then
        return
    end
    if c.size_hints.user_position or c.size_hints.program_position then
        return
    end
    awful.placement.no_offscreen(c)
end)

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {
        raise = false
    })
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)

client.connect_signal("property::floating", function (c)
    c.ontop = c.floating and not c.fullscreen
end)

client.connect_signal("property::maximized", function (c)
    c.maximized = false
end)

