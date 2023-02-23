local wibox = require("wibox")

local Time = {}
Time.__index = Time

function Time:new(args)
    local time = setmetatable({}, Time)
    local clock = wibox.widget.textclock()
    clock.format = args and args.time_format or "%H:%M"
    local container = wibox.container.margin(clock)
    time.__widget = container
    container.left = 8
    container.right = 8
    return time
end

return setmetatable(Time, {
    __call = function (_, ...)
        local time = Time:new(...)
        return time.__widget
    end
})

