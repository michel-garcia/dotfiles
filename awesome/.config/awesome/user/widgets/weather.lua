local awful = require("awful")
local wibox = require("wibox")

local M = {}

local ICON_SUNNY = "󰖙"
local ICON_NIGHT = "󰖔"
local ICON_PARTLY_CLOUDY = "󰖕"
local ICON_NIGHT_PARTLY_CLOUDY = "󰼱"
local ICON_FOG = "󰖑"
local ICON_RAINY = "󰖗"
local ICON_POURING = "󰖖"
local ICON_SNOWY = "󰖘"

local XREF = {
    [0] = { "Clear Sky", ICON_SUNNY, ICON_NIGHT },
    [1] = { "Mainly Clear", ICON_SUNNY, ICON_NIGHT },
    [2] = { "Partly Cloudy", ICON_PARTLY_CLOUDY, ICON_NIGHT_PARTLY_CLOUDY },
    [3] = { "Overcast", ICON_PARTLY_CLOUDY, ICON_NIGHT_PARTLY_CLOUDY },
    [45] = { "Fog", ICON_FOG, ICON_FOG },
    [48] = { "Fog", ICON_FOG, ICON_FOG },
    [51] = { "Drizzle", ICON_RAINY, ICON_RAINY },
    [53] = { "Drizzle", ICON_RAINY, ICON_RAINY },
    [55] = { "Drizzle", ICON_RAINY, ICON_RAINY },
    [56] = { "Freezing Drizzle", ICON_RAINY, ICON_RAINY },
    [57] = { "Freezing Drizzle", ICON_RAINY, ICON_RAINY },
    [61] = { "Rain", ICON_POURING, ICON_POURING },
    [63] = { "Rain", ICON_POURING, ICON_POURING },
    [65] = { "Rain", ICON_POURING, ICON_POURING },
    [66] = { "Freezing Rain", ICON_POURING, ICON_POURING },
    [67] = { "Freezing Rain", ICON_POURING, ICON_POURING },
    [71] = { "Snow", ICON_SNOWY, ICON_SNOWY },
    [73] = { "Snow", ICON_SNOWY, ICON_SNOWY },
    [75] = { "Snow", ICON_SNOWY, ICON_SNOWY },
    [77] = { "Snow Grains", ICON_SNOWY, ICON_SNOWY },
    [80] = { "Rain Showers", ICON_POURING, ICON_POURING },
    [81] = { "Rain Showers", ICON_POURING, ICON_POURING },
    [82] = { "Rain Showers", ICON_POURING, ICON_POURING },
    [85] = { "Snow Showers", ICON_SNOWY, ICON_SNOWY },
    [86] = { "Snow Showers", ICON_SNOWY, ICON_SNOWY }

}

function M:new(args)
    local widget = wibox.widget({
        layout = wibox.container.margin,
        left = 8,
        right = 8,
        {
            layout = wibox.layout.fixed.horizontal,
            {
                widget = wibox.widget.textbox,
                id = "icon",
                text = ICON_SUNNY
            },
            {
                widget = wibox.container.margin,
                left = 8
            },
            {
                widget = wibox.widget.textbox,
                id = "desc",
                text = "..."
            },
            {
                widget = wibox.container.margin,
                left = 8
            },
            {
                widget = wibox.widget.textbox,
                id = "temp",
                text = "0.0°"
            }
        }
    })
    self.latitude = args and args.latitude or 52.52
    self.longitude = args and args.longitude or 13.41
    timer({
        autostart = true,
        callback = function ()
            self:update(widget)
        end,
        timeout = args and args.timeout or 120
    })
    self:update(widget)
    return widget
end

function M:update(widget)
    local url = string.format(
        "https://api.open-meteo.com/v1/forecast?latitude=%s&longitude=%s&current_weather=true",
        self.latitude,
        self.longitude
    )
    awful.spawn.easy_async(string.format("curl '%s'", url), function (output)
        self.temperature = output:match("\"temperature\":([%d%.]+)")
        self.code = output:match("\"weathercode\":(%d+)")
        self:refresh(widget)
    end)
    collectgarbage("collect")
end

function M:refresh(widget)
    local index = tonumber(self.code)
    local description, icon0, icon1 = table.unpack(XREF[index])
    local hour = tonumber(os.date("%H"))
    local icon = table.unpack(widget:get_children_by_id("icon"))
    local daylight = hour >= 6 and hour < 18
    icon.text = daylight and icon0 or icon1
    local desc = table.unpack(widget:get_children_by_id("desc"))
    desc.text = description
    local temp = table.unpack(widget:get_children_by_id("temp"))
    temp.text = string.format("%s°", self.temperature)
end

return setmetatable(M, {
    __call = function (_, ...)
        return M:new(...)
    end
})
