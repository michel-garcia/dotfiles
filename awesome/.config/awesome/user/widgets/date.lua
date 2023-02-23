local wibox = require("wibox")

local Date = {}
Date.__index = Date

function Date:new(args)
    local date = setmetatable({}, Date)
    local clock = wibox.widget.textclock()
    clock.format = args and args.format or "%a, %b %-e"
    local container = wibox.container.margin(clock)
    date.__widget = container
    container.left = 8
    container.right = 8
    return date
end

return setmetatable(Date, {
    __call = function (_, ...)
        local date = Date:new(...)
        return date.__widget
    end
})

