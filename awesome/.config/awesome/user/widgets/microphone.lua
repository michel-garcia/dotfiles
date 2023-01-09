local awful = require("awful")
local timer = require("gears.timer")
local wibox = require("wibox")

local ICON_NORMAL = "󰍬"
local ICON_MUTED = "󰍭"

local M = {}

function M:new(args)
    local widget = wibox.widget({
        layout = wibox.container.margin,
        left = 8,
        right = 8,
        {
            widget = wibox.widget.textbox,
            id = "icon",
            font = "Material Design Icons",
            text = ICON_NORMAL
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
    awful.spawn.easy_async("pactl get-default-source", function (output)
        local source = output:match("([^\n]+)")
        self:update_source_volume(source, function ()
            self:refresh(widget)
        end)
        self:update_source_mute(source, function ()
            self:refresh(widget)
        end)
    end)
    collectgarbage("collect")
end

function M:update_source_volume(source, callback)
    awful.spawn.easy_async(string.format("pactl get-source-volume %s", source), function (output)
        local volume = output:match("(%d+)%%")
        self.volume = tonumber(volume)
        if callback then
            callback()
        end
    end)
end

function M:update_source_mute(source, callback)
    awful.spawn.easy_async(string.format("pactl get-source-mute %s", source), function (output)
        local mute = output:match(":%s([%a]+)")
        self.muted = mute == "yes"
        if callback then
            callback()
        end
    end)
end

function M:refresh(widget)
    local icon = table.unpack(widget:get_children_by_id("icon"))
    if not self.muted then
        icon.text = ICON_NORMAL
    else
        icon.text = ICON_MUTED
    end
end

return setmetatable(M, {
    __call = function (_, ...)
        return M:new(...)
    end
})

