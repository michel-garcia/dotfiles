local awful = require("awful")
local timer = require("gears.timer")
local wibox = require("wibox")

local M = {}

local ICON_VOLUME_HIGH = "\u{f057e}"
local ICON_VOLUME_MEDIUM = "\u{f0580}"
local ICON_VOLUME_LOW = "\u{f057f}"
local ICON_VOLUME_MUTE = "\u{f075f}"

M.volume = 0
M.muted = false

function M:new(args)
    local widget = wibox.widget({
        layout = wibox.container.margin,
        left = 8,
        right = 8,
        {
            widget = wibox.widget.textbox,
            id = "icon",
            font = "FiraCode Nerd Font Mono 14",
            text = ICON_VOLUME_HIGH
        }
    })
    self:attach_tooltip(widget)
    timer({
        autostart = true,
        callback = function ()
            self:update(widget)
        end,
        timeout = args and args.timeout or 5
    })
    self:update(widget)
    return widget
end

function M:attach_tooltip(widget)
    local tooltip = awful.tooltip({
        mode = "outside",
        objects = { widget },
        preferred_alignments = { "middle" }
    })
    widget:connect_signal("mouse::enter", function ()
        tooltip.text = string.format("Volume: %s%%", self.volume)
    end)
end

function M:update(widget)
    awful.spawn.easy_async("pactl get-default-sink", function (output)
        local sink = output:match("([^\n]+)")
        self:update_sink_volume(sink, function ()
            self:refresh(widget)
        end)
        self:update_sink_mute(sink, function()
            self:refresh(widget)
        end)
    end)
    collectgarbage("collect")
end

function M:update_sink_volume(sink, callback)
    awful.spawn.easy_async(string.format("pactl get-sink-volume %s", sink), function (output)
        local volume = output:match("(%d+)%%")
        self.volume = tonumber(volume)
        if callback then
            callback()
        end
    end)
end

function M:update_sink_mute(sink, callback)
    awful.spawn.easy_async(string.format("pactl get-sink-mute %s", sink), function (output)
        local mute = output:match(":%s([%a]+)")
        self.muted = mute == "yes"
        if callback then
            callback()
        end
    end)
end

function M:refresh(widget)
    local icon = widget:get_children_by_id("icon")[1]
    if self.muted then
        icon:set_text(ICON_VOLUME_MUTE)
    elseif self.volume > 80 then
        icon:set_text(ICON_VOLUME_HIGH)
    elseif self.volume > 40 then
        icon:set_text(ICON_VOLUME_MEDIUM)
    else
       icon:set_text(ICON_VOLUME_LOW)
    end
end

return setmetatable(M, {
    __call = function (_, ...)
        return M:new(...)
    end
})

