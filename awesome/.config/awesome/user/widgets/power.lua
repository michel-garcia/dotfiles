local wibox = require("wibox")

local M = {}

function M:new(args)
    local widget = wibox.widget({
        layout = wibox.container.margin,
        left = 8,
        right = 8,
        {
            widget = wibox.widget.textbox,
            font = "Material Design Icons",
            text = "󰤆"
        }
    })
    return widget
end

return setmetatable(M, {
    __call = function (_, ...)
        return M:new(...)
    end
})
