local wibox = require("wibox")

return function ()
    local systray = wibox.widget.systray()
    local container = wibox.container.margin(systray)
    container.bottom = 4
    container.left = 8
    container.right = 8
    container.top = 4
    return container
end

