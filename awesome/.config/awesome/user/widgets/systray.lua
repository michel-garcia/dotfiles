local wibox = require("wibox")

local Systray = function ()
    local widget = wibox.widget({
        layout = wibox.container.margin,
        left = 4,
        right = 4,
        {
            layout = wibox.container.place,
            valign = "center",
            {
                base_size = 16,
                forced_height = 16,
                widget = wibox.widget.systray
            }
        }
    })
    return widget
end

return Systray
