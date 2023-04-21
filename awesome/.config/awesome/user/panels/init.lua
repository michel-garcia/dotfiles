local awful = require("awful")

local TopPanel = require("user.panels.top")

awful.screen.connect_for_each_screen(function (s)
    s.top_panel = TopPanel(s)
end)

