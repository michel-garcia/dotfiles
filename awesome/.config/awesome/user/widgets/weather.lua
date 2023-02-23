local awful = require("awful")
local icons = require("user.theme.icons")
local wibox = require("wibox")

local Weather = {}
Weather.__index = Weather

Weather.xref = {
    [0] = { "Clear Sky", icons.weather_day_sunny, icons.weather_night_clear },
    [1] = { "Mainly Clear", icons.weather_day_sunny, icons.weather_night_clear },
    [2] = { "Partly Cloudy", icons.weather_day_cloudy, icons.weather_night_cloudy },
    [3] = { "Overcast", icons.weather_day_cloudy, icons.weather_night_cloudy },
    [45] = { "Fog", icons.weather_day_fog, icons.weather_night_fog },
    [48] = { "Fog", icons.weather_day_fog, icons.weather_night_fog },
    [51] = { "Drizzle", icons.weather_day_rain, icons.weather_night_rain },
    [53] = { "Drizzle", icons.weather_day_rain, icons.weather_night_rain },
    [55] = { "Drizzle", icons.weather_day_rain, icons.weather_night_rain },
    [56] = { "Freezing Drizzle", icons.weather_day_rain, icons.weather_night_rain },
    [57] = { "Freezing Drizzle", icons.weather_day_rain, icons.weather_night_rain },
    [61] = { "Rain", icons.weather_day_thunderstorm, icons.weather_night_thunderstorm },
    [63] = { "Rain", icons.weather_day_thunderstorm, icons.weather_night_thunderstorm },
    [65] = { "Rain", icons.weather_day_thunderstorm, icons.weather_night_thunderstorm },
    [66] = { "Freezing Rain", icons.weather_day_thunderstorm, icons.weather_night_thunderstorm },
    [67] = { "Freezing Rain", icons.weather_day_thunderstorm, icons.weather_night_thunderstorm },
    [71] = { "Snow", icons.weather_day_snow, icons.weather_night_snow },
    [73] = { "Snow", icons.weather_day_snow, icons.weather_night_snow },
    [75] = { "Snow", icons.weather_day_snow, icons.weather_night_snow },
    [77] = { "Snow Grains", icons.weather_day_snow, icons.weather_night_snow },
    [80] = { "Rain Showers", icons.weather_day_thunderstorm, icons.weather_night_thunderstorm },
    [81] = { "Rain Showers", icons.weather_day_thunderstorm, icons.weather_night_thunderstorm },
    [82] = { "Rain Showers", icons.weather_day_thunderstorm, icons.weather_night_thunderstorm },
    [85] = { "Snow Showers", icons.weather_day_snow, icons.weather_night_snow },
    [86] = { "Snow Showers", icons.weather_day_snow, icons.weather_night_snow }
}

function Weather:new(args)
    local weather = setmetatable({}, Weather)
    weather.latitude = args and args.latitude or 52.52
    weather.longitude = args and args.longitude or 13.41
    local icon = wibox.widget.textbox()
    weather.__icon = icon
    icon.font = "FiraCode Nerd Font Mono 18"
    icon.text = icons.weather_day_sunny
    local spacing = wibox.container.margin()
    spacing.right = 8
    local desc = wibox.widget.textbox()
    weather.__desc = desc
    desc.text = "Clear Sky"
    local temp = wibox.widget.textbox()
    weather.__temp = temp
    temp.text = "0.0°"
    local layout = wibox.layout.fixed.horizontal()
    layout:add(icon)
    layout:add(spacing)
    layout:add(desc)
    layout:add(spacing)
    layout:add(temp)
    local container = wibox.container.margin(layout)
    weather.__widget = container
    container.left = 8
    container.right = 8
    timer({
        autostart = true,
        callback = function ()
            weather:update()
        end,
        timeout = args and args.timeout or 120
    })
    weather:update()
    return weather
end

function Weather:update()
    local url = string.format(
        "https://api.open-meteo.com/v1/forecast?latitude=%s&longitude=%s&current_weather=true",
        self.latitude,
        self.longitude
    )
    awful.spawn.easy_async(string.format("curl '%s'", url), function (output)
        self.temperature = output:match("\"temperature\":([%d%.]+)")
        self.code = tonumber(output:match("\"weathercode\":(%d+)"))
        self:refresh()
    end)
    collectgarbage("collect")
end

function Weather:refresh()
    local index = self.xref[self.code] and self.code or 1
    local desc, icon0, icon1 = table.unpack(self.xref[index])
    local hour = tonumber(os.date("%H"))
    local daylight = hour >= 6 and hour < 18
    self.__icon.text = daylight and icon0 or icon1
    self.__desc.text = desc
    self.__temp.text = string.format("%s°", self.temperature)
end

return setmetatable(Weather, {
    __call = function (_, ...)
        local weather = Weather:new(...)
        return weather.__widget
    end
})
