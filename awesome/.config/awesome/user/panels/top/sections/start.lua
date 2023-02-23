local wibox = require("wibox")
local date = require("user.widgets.date")
local time = require("user.widgets.time")
local weather = require("user.widgets.weather")

local M = {}

function M:new(_)
    local layout = wibox.layout.fixed.horizontal(
        date(),
        time(),
        weather({
            latitude = 25.76,
            longitude = -80.19
        })
    )
    local margin = wibox.container.margin(layout)
    margin.left = 4
    margin.right = 4
    local container = wibox.container.place(margin)
    container.halign = "left"
    return container
end

return setmetatable(M, {
    __call = function (_, ...)
        return M:new(...)
    end
})

