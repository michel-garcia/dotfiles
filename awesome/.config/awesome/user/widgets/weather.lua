local awful = require("awful")
local wibox = require("wibox")

local M = {}

local ICON_DAY_SUNNY = "\u{e30d}"
local ICON_NIGHT_CLEAR = "\u{e32b}"
local ICON_DAY_CLOUDY = "\u{e302}"
local ICON_NIGHT_CLOUDY = "\u{e32e}"
local ICON_DAY_FOG = "\u{e303}"
local ICON_NIGHT_FOG = "u{e346}"
local ICON_DAY_RAIN = "\u{e308}"
local ICON_NIGHT_RAIN = "u{e333}"
local ICON_DAY_THUNDERSTORM = "\u{e30f}"
local ICON_NIGHT_THUNDERSTORM = "\u{e338}"
local ICON_DAY_SNOW = "\u{e30a}"
local ICON_NIGHT_SNOW = "\u{e335}"

local XREF = {
    [0] = { "Clear Sky", ICON_DAY_SUNNY, ICON_NIGHT_CLEAR },
    [1] = { "Mainly Clear", ICON_DAY_SUNNY, ICON_NIGHT_CLEAR },
    [2] = { "Partly Cloudy", ICON_DAY_CLOUDY, ICON_NIGHT_CLOUDY },
    [3] = { "Overcast", ICON_DAY_CLOUDY, ICON_NIGHT_CLOUDY },
    [45] = { "Fog", ICON_DAY_FOG, ICON_NIGHT_FOG },
    [48] = { "Fog", ICON_DAY_FOG, ICON_NIGHT_FOG },
    [51] = { "Drizzle", ICON_DAY_RAIN, ICON_NIGHT_RAIN },
    [53] = { "Drizzle", ICON_DAY_RAIN, ICON_NIGHT_RAIN },
    [55] = { "Drizzle", ICON_DAY_RAIN, ICON_NIGHT_RAIN },
    [56] = { "Freezing Drizzle", ICON_DAY_RAIN, ICON_NIGHT_RAIN },
    [57] = { "Freezing Drizzle", ICON_DAY_RAIN, ICON_NIGHT_RAIN },
    [61] = { "Rain", ICON_DAY_THUNDERSTORM, ICON_NIGHT_THUNDERSTORM },
    [63] = { "Rain", ICON_DAY_THUNDERSTORM, ICON_NIGHT_THUNDERSTORM },
    [65] = { "Rain", ICON_DAY_THUNDERSTORM, ICON_NIGHT_THUNDERSTORM },
    [66] = { "Freezing Rain", ICON_DAY_THUNDERSTORM, ICON_NIGHT_THUNDERSTORM },
    [67] = { "Freezing Rain", ICON_DAY_THUNDERSTORM, ICON_NIGHT_THUNDERSTORM },
    [71] = { "Snow", ICON_DAY_SNOW, ICON_NIGHT_SNOW },
    [73] = { "Snow", ICON_DAY_SNOW, ICON_NIGHT_SNOW },
    [75] = { "Snow", ICON_DAY_SNOW, ICON_NIGHT_SNOW },
    [77] = { "Snow Grains", ICON_DAY_SNOW, ICON_NIGHT_SNOW },
    [80] = { "Rain Showers", ICON_DAY_THUNDERSTORM, ICON_NIGHT_THUNDERSTORM },
    [81] = { "Rain Showers", ICON_DAY_THUNDERSTORM, ICON_NIGHT_THUNDERSTORM },
    [82] = { "Rain Showers", ICON_DAY_THUNDERSTORM, ICON_NIGHT_THUNDERSTORM },
    [85] = { "Snow Showers", ICON_DAY_SNOW, ICON_NIGHT_SNOW },
    [86] = { "Snow Showers", ICON_DAY_SNOW, ICON_NIGHT_SNOW }

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
                font = "FiraCode Nerd Font Mono 14",
                id = "icon",
                text = ICON_DAY_SUNNY
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
        self.code = tonumber(output:match("\"weathercode\":(%d+)"))
        self:refresh(widget)
    end)
    collectgarbage("collect")
end

function M:refresh(widget)
    local index = XREF[self.code] and self.code or 1
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
