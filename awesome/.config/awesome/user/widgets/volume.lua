local awful = require("awful")
local timer = require("gears.timer")
local wibox = require("wibox")

local ICONS = {
    high = "󰕾",
    medium = "󰖀",
    low = "󰕿",
    mute = "󰝟"
}

local M = {}

M.volume = 0
M.muted = false

function M:new(args)
    M.root = wibox.widget({
        layout = wibox.container.margin,
        margins = 4,
        {
            widget = wibox.widget.textbox,
            id = "icon",
            font = "Material Design Icons",
            text = ICONS.mute
        }
    })
    local tooltip = awful.tooltip({
        mode = "outside",
        objects = { M.root },
        preferred_alignments = { "middle" }
    })
    M.root:connect_signal("mouse::enter", function ()
        tooltip.text = string.format("Volume: %s%%", self.volume)
    end)
    timer({
        autostart = true,
        callback = function ()
            self:update()
        end,
        timeout = args and args.timeout or 5
    })
    self:update()
    return M.root
end

function M:update()
    self:update_volume()
end

function M:update_volume()
    awful.spawn.easy_async("pacmd list-sinks", function (output)
        local volume, muted = output:match("%*%sindex.-front%-left.-%/%s+(%d+)%%.-muted:%s(%a+)")
        self.volume = tonumber(volume)
        self.muted = muted == "yes"
        self:refresh()
    end)
end

function M:refresh()
    if self.muted then
        self:set_icon(ICONS.muted)
    else
        if self.volume > 80 then
            self:set_icon(ICONS.high)
        elseif self.volume >= 40 then
            self:set_icon(ICONS.medium)
        else
            self:set_icon(ICONS.low)
        end
    end
end

function M:set_icon(icon)
    local widget = self.root:get_children_by_id("icon")[1]
    widget.text = icon
end

return setmetatable(M, {
    __call = function (_, ...)
        return M:new(...)
    end
})

