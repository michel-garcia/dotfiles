local awful = require("awful")
local wibox = require("wibox")

local Airplane = require("user.widgets.airplane")
local Battery = require("user.widgets.battery")
local Clock = require("user.widgets.clock")
local Network = require("user.widgets.network")
local Taglist = require("user.widgets.taglist")
local Redshift = require("user.widgets.redshift")
local Systray = require("user.widgets.systray")
local Volume = require("user.widgets.volume")

local airplane = Airplane()
local battery = Battery()
local clock = Clock()
local network = Network()
local redshift = Redshift()
local systray = Systray()
local volume = Volume()

local Left = function ()
    local layout = wibox.layout.fixed.horizontal(clock, systray)
    local container = wibox.container.place(layout, "left")
    return container
end

local Center = function (args)
    local taglist = Taglist(args.screen)
    local container = wibox.container.place(taglist, "center")
    return container
end

local Right = function ()
    local layout = wibox.layout.fixed.horizontal(
        redshift,
        network,
        airplane,
        volume,
        battery
    )
    local container = wibox.container.place(layout, "right")
    return container
end

local Container = function (args)
    local left = Left()
    local center = Center(args)
    local right = Right()
    local stack = wibox.layout.stack(nil, left, center, right)
    local container = wibox.container.margin(stack, 4, 4)
    return container
end

local TopPanel = function (s)
    local container = Container({ screen = s })
    local top_panel = awful.wibar({
        position = "top",
        screen = s,
        widget = container
    })
    return top_panel
end

return TopPanel
