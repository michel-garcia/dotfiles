local wibox = require("wibox")

local M = {}

function M:new(args)
    self.widget = wibox.widget({
        layout = wibox.container.margin,
        left = 8,
        right = 8,
        {
            format = args and args.format or "%H:%M",
            widget = wibox.widget.textclock
        }
    })
    return self.widget
end

return setmetatable(M, {
    __call = function (_, ...)
        return M:new(...)
    end
})

