local awful = require("awful")

local TopPanel = require("user.panels.top")

awful.screen.connect_for_each_screen(function (s)
    if s.top_panel then
        s.top_panel:remove()
    end
    s.top_panel = TopPanel(s)
end)

screen.connect_signal("primary_changed", function (s)
    if s.top_panel then
        s.top_panel:remove()
    end
    s.top_panel = TopPanel(s)
end)

