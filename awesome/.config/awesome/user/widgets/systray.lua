local wibox = require("wibox")

return function ()
    return wibox.widget({
        layout = wibox.container.margin,
        left = 8,
        right = 8,
        top = 3,
        bottom = 3,
        {
            widget = wibox.widget.systray
        }
    })
end

