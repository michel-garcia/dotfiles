local awful = require("awful")
local wibox = require("wibox")

local clock = require("user.widgets.clock")
local taglist = require("user.widgets.taglist")
local systray = require("user.widgets.systray")
local volume = require("user.widgets.volume")
local network = require("user.widgets.network")

awful.screen.connect_for_each_screen(function(s)
    if s ~= screen.primary then
        return
    end
    s.taglist = taglist(s)
    s.wibar = awful.wibar({
        position = "top",
        screen = s
    })
    s.wibar:setup({
        layout = wibox.layout.stack,
        {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
                clock(),
                systray()
            },
            nil,
            {
                layout = wibox.layout.fixed.horizontal,
                volume(),
                network()
            }
        },
        {
            s.taglist,
            layout = wibox.container.place,
            halign = "center",
            valign = "center"
        }
    })
end)

