local awful = require("awful")
local top_panel = require("user.panels.top")

awful.screen.connect_for_each_screen(function (s)
    top_panel(s)
end)

