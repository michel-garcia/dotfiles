local awful = require("awful")

local Taglist = function (s)
    local widget = awful.widget.taglist({
        filter = awful.widget.taglist.filter.all,
        screen = s
    })
    return widget
end

return Taglist
