local awful = require("awful")
local beautiful = require("beautiful")
local icons = require("user.theme.icons")
local timer = require("gears.timer")
local wibox = require("wibox")

local Volume = {}
Volume.__index = Volume

Volume.volume = 0
Volume.muted = false

function Volume:new(args)
    local volume = setmetatable({}, Volume)
    local icon = wibox.widget.textbox()
    icon.font = beautiful.widget_icon_font
    icon.text = icons.volume_mute
    local container = wibox.container.margin(icon)
    volume.__widget = container
    container.left = 8
    container.right = 8
    volume:attach_tooltip(container)
    timer({
        autostart = true,
        callback = function ()
            volume:update(icon)
        end,
        timeout = args and args.timeout or 1
    })
    volume:update(icon)
    return volume
end

function Volume:attach_tooltip(widget)
    local tooltip = awful.tooltip({
        mode = "outside",
        objects = { widget },
        preferred_alignments = { "middle" }
    })
    widget:connect_signal("mouse::enter", function ()
        tooltip.text = string.format("Volume: %s%%", self.volume)
    end)
end

function Volume:update(widget)
    self:update_sink_volume(function ()
        self:refresh(widget)
    end)
    self:update_sink_mute(function()
        self:refresh(widget)
    end)
    collectgarbage("collect")
end

function Volume:update_sink_volume(callback)
    awful.spawn.easy_async("pactl get-sink-volume @DEFAULT_SINK@", function (output)
        local volume = output:match("(%d+)%%")
        self.volume = tonumber(volume)
        if callback then
            callback()
        end
    end)
end

function Volume:update_sink_mute(callback)
    awful.spawn.easy_async("pactl get-sink-mute @DEFAULT_SINK@", function (output)
        local mute = output:match(":%s([%a]+)")
        self.muted = mute == "yes"
        if callback then
            callback()
        end
    end)
end

function Volume:refresh(widget)
    if self.muted then
        widget.text = icons.volume_mute
    elseif type(self.volume) == "number" then
        if self.volume > 80 then
            widget.text = icons.volume_high
        elseif self.volume > 40 then
            widget.text = icons.volume_medium
        else
           widget.text = icons.volume_low
        end
    end
end

return setmetatable(Volume, {
    __call = function (_, ...)
        local volume = Volume:new(...)
        return volume.__widget
    end
})

