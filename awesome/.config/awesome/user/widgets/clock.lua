local wibox = require("wibox")

local Clock = function ()
    local date = wibox.widget.textclock()
    date.format = "%a, %b %-e"
    local time = wibox.widget.textclock()
    time.format = "%H:%M:%S"
    time.refresh = 1
    local layout = wibox.layout.fixed.horizontal(date, time)
    layout.spacing = 8
    return wibox.container.margin(layout, 4, 4)
end

return Clock
