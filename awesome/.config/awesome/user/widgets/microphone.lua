local awful = require("awful")
local beautiful = require("beautiful")
local icons = require("user.theme.icons")
local timer = require("gears.timer")
local wibox = require("wibox")

local Microphone = {}
Microphone.__index = Microphone

Microphone.volume = 0

function Microphone:new(args)
    local microphone = setmetatable({}, Microphone)
    local icon = wibox.widget.textbox()
    icon.font = beautiful.widget_icon_font
    icon.text = icons.microphone_off
    local container = wibox.container.margin(icon)
    microphone.__widget = container
    container.left = 8
    container.right = 8
    microphone:attach_tooltip(container)
    timer({
        autostart = true,
        callback = function ()
            microphone:update(icon)
        end,
        timeout = args and args.timeout or 1
    })
    microphone:update(icon)
    return microphone
end

function Microphone:attach_tooltip(widget)
    local tooltip = awful.tooltip({
        mode = "outside",
        objects = { widget },
        preferred_alignments = { "middle" }
    })
    widget:connect_signal("mouse::enter", function ()
        tooltip.text = string.format("Volume: %s%%", self.volume)
    end)
end

function Microphone:update(widget)
    self:update_source_volume(function ()
        self:refresh(widget)
    end)
    self:update_source_mute(function ()
        self:refresh(widget)
    end)
    collectgarbage("collect")
end

function Microphone:update_source_volume(callback)
    awful.spawn.easy_async("pactl get-source-volume @DEFAULT_SOURCE@", function (output)
        local volume = output:match("(%d+)%%")
        self.volume = tonumber(volume)
        if callback then
            callback()
        end
    end)
end

function Microphone:update_source_mute(callback)
    awful.spawn.easy_async("pactl get-source-mute @DEFAULT_SOURCE@", function (output)
        local mute = output:match(":%s([%a]+)")
        self.muted = mute == "yes"
        if callback then
            callback()
        end
    end)
end

function Microphone:refresh(widget)
    if not self.muted then
        widget.text = icons.microphone
    else
        widget.text = icons.microphone_off
    end
end

return setmetatable(Microphone, {
    __call = function (_, ...)
        local microphone = Microphone:new(...)
        return microphone.__widget
    end
})

