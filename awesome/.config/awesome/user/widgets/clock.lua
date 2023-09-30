local wibox = require("wibox")

local Clock = function ()
    local widget = wibox.widget({
        layout = wibox.container.margin,
        left = 4,
        right = 4,
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = 8,
            {
                format = "%a, %b %-e",
                widget = wibox.widget.textclock
            },
            {
                format = "%H:%M:%S",
                refresh = 1,
                widget = wibox.widget.textclock
            }
        }
    })
    return widget
end

return Clock
