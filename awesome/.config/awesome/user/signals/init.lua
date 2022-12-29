local awful = require("awful")
local beautiful = require("beautiful")

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

