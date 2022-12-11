local awful = require("awful")
local wibox = require("wibox")

local clock = require("user.widgets.clock")
local taglist = require("user.widgets.taglist")
local systray = require("user.widgets.systray")

awful.screen.connect_for_each_screen(function(s)
    if s ~= screen.primary then
        return
    end
    s.mytaglist = taglist(s)
    s.mywibox = awful.wibar({
        position = "top", screen = s
    })
    s.mywibox:setup({
        layout = wibox.layout.stack,
        {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
                clock(),
            },
            nil,
            {
                layout = wibox.layout.fixed.horizontal,
                systray(),
            }
        },
        {
            s.mytaglist,
            valign = "center",
            halign = "center",
            layout = wibox.container.place
        }
    })
end)

