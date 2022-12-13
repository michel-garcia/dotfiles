local wibox = require("wibox")

return function ()
    return wibox.widget({
        layout = wibox.container.margin,
        margins = 4,
        {
            widget = wibox.widget.systray()
        }
    })
end

