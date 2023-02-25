local awful = require("awful")
local wibox = require("wibox")
local timer = require("gears.timer")
local icons = require("user.theme.icons")

local Battery = {}
Battery.__index = Battery

Battery.device = "BAT0"
Battery.capacity = 0
Battery.status = "Unknown"

function Battery:new(args)
    local battery = setmetatable({}, Battery)
    battery.device = args and args.device or Battery.device
    local icon = wibox.widget.textbox()
    icon.font = "FiraCode Nerd Font Mono 18"
    icon.text = icons.battery_outline
    local container = wibox.container.margin(icon)
    battery.__widget = container
    container.left = 8
    container.right = 8
    container.visible = false
    battery:attach_tooltip(container)
    timer({
        autostart = true,
        callback = function ()
            battery:update(icon)
        end,
        timeout = args and args.timeout or 4
    })
    battery:update(icon)
    return battery
end

function Battery:attach_tooltip(widget)
    local tooltip = awful.tooltip({
        mode = "outside",
        objects = { widget },
        preferred_alignments = { "middle" }
    })
    widget:connect_signal("mouse::enter", function ()
        tooltip.text = string.format(
            "Battery: %s%% - %s",
            self.capacity,
            self.status
        )
    end)
end

function Battery:update(widget)
    local capacity_command = string.format(
        "cat /sys/class/power_supply/%s/capacity",
        self.device
    )
    awful.spawn.easy_async(capacity_command, function (output)
        self.capacity = tonumber(output)
        self.__widget.visible = output ~= ""
        self:refresh(widget)
    end)
    local status_command = string.format(
        "cat /sys/class/power_supply/%s/status",
        self.device
    )
    awful.spawn.easy_async(status_command, function (output)
        local pattern = "(%a+)%s$"
        self.status = output:match(pattern)
        self:refresh(widget)
    end)
    collectgarbage("collect")
end

function Battery:refresh(widget)
    local full = self.status == "Full"
    local charging = self.status == "Charging"
    if self.status == "Unknown" then
        widget.text = icons.battery_unknown
    elseif self.capacity == 100 then
        if full then
            widget.text = icons.battery_charging_100
        else
            widget.text = icons.battery
        end
    elseif self.capacity >= 90 then
        if charging then
            widget.text = icons.battery_charging_90
        else
            widget.text = icons.battery_90
        end
    elseif self.capacity >= 80 then
        if charging then
            widget.text = icons.battery_charging_80
        else
            widget.text = icons.battery_80
        end
    elseif self.capacity >= 70 then
        if charging then
            widget.text = icons.battery_charging_70
        else
            widget.text = icons.battery_70
        end
    elseif self.capacity >= 60 then
        if charging then
            widget.text = icons.battery_charging_60
        else
            widget.text = icons.battery_60
        end
    elseif self.capacity >= 50 then
        if charging then
            widget.text = icons.battery_charging_50
        else
            widget.text = icons.battery_50
        end
    elseif self.capacity >= 40 then
        if charging then
            widget.text = icons.battery_charging_40
        else
            widget.text = icons.battery_40
        end
    elseif self.capacity >= 30 then
        if charging then
            widget.text = icons.battery_charging_30
        else
            widget.text = icons.battery_30
        end
    elseif self.capacity >= 20 then
        if charging then
            widget.text = icons.battery_charging_20
        else
            widget.text = icons.battery_20
        end
    elseif self.capacity >= 10 then
        if charging then
            widget.text = icons.battery_charging_10
        else
            widget.text = icons.battery_10
        end
    else
        if charging then
            widget.text = icons.battery_charging_outline
        else
            widget.text = icons.battery_outline
        end
    end
end

return setmetatable(Battery, {
    __call = function (_, ...)
        local battery = Battery:new(...)
        return battery.__widget
    end
})

