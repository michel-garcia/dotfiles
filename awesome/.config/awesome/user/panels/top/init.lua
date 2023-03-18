local awful = require("awful")
local wibox = require("wibox")

local StartSection = require("user.panels.top.sections.start")
local CenterSection = require("user.panels.top.sections.center")
local EndSection = require("user.panels.top.sections.end")

local TopPanel = function (s)
    local top_panel = awful.wibar({
        position = "top",
        screen = s
    })
    local stack = wibox.layout.stack()
    top_panel.widget = stack
    if s == screen.primary then
        local start_section = StartSection()
        stack:add(start_section)
    end
    local center_section = CenterSection({ screen = s })
    stack:add(center_section)
    if s == screen.primary then
        local end_section = EndSection()
        stack:add(end_section)
    end
end

return TopPanel

