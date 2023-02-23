local wibox = require("wibox")
local battery = require("user.widgets.battery")
local brightness = require("user.widgets.brightness")
local keyboard = require("user.widgets.keyboard")
local microphone = require("user.widgets.microphone")
local network = require("user.widgets.network")
local systray = require("user.widgets.systray")
local volume = require("user.widgets.volume")

local M = {}

function M:new(_)
    local layout = wibox.layout.fixed.horizontal(
        systray(),
        keyboard(),
        brightness(),
        network(),
        volume(),
        microphone(),
        battery()
    )
    local margin = wibox.container.margin(layout)
    margin.left = 4
    margin.right = 4
    local container = wibox.container.place(margin)
    container.halign = "right"
    return container
end

return setmetatable(M, {
    __call = function (_, ...)
        return M:new(...)
    end
})

