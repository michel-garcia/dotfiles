local awful = require("awful")
local wibox = require("wibox")
local start_section = require("user.panels.top.sections.start")
local center_section = require("user.panels.top.sections.center")
local end_section = require("user.panels.top.sections.end")

local top_panel = function (s)
    local wibar = awful.wibar({
        position = "top",
        screen = s
    })
    local stack = wibox.layout.stack()
    wibar.widget = stack
    if s == screen.primary then
        stack:add(start_section())
    end
    stack:add(center_section({
        screen = s
    }))
    if s == screen.primary then
        stack:add(end_section())
    end
end

return top_panel

