local wibox = require("wibox")

local Systray = function ()
    local systray = wibox.widget.systray()
    systray.forced_height = 16
    systray:set_base_size(systray.forced_height)
    local container = wibox.container.place(systray, "center", "center")
    return wibox.container.margin(container, 4, 4)
end

return Systray
