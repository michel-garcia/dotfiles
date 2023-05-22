local awful = require("awful")
local wibox = require("wibox")

local Taglist = function (s)
    local widget = awful.widget.taglist({
        filter = awful.widget.taglist.filter.all,
        screen = s
    })
    return wibox.container.margin(widget, 4, 4)
end

return Taglist
