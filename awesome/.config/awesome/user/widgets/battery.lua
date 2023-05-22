local wibox = require("wibox")

local Status = {
    CHARGING = "Charging",
    DISCHARGING = "Discharging",
    FULL = "Full",
    NOT_CHARGING = "Not charging",
    UNKNOWN = "Unknown"
}

local Icon = {
    BATTERY_UNKNOWN = "\u{f0091}",
    BATTERY_FULL = "\u{f17e2}",
    BATTERY_100 = "\u{f0079}",
    BATTERY_100_CHARGING = "\u{f0085}",
    BATTERY_90 = "\u{f0082}",
    BATTERY_90_CHARGING = "\u{f008b}",
    BATTERY_80 = "\u{f0081}",
    BATTERY_80_CHARGING = "\u{f008a}",
    BATTERY_70 = "\u{f0080}",
    BATTERY_70_CHARGING = "\u{f089e}",
    BATTERY_60 = "\u{f007f}",
    BATTERY_60_CHARGING = "\u{f0089}",
    BATTERY_50 = "\u{f007e}",
    BATTERY_50_CHARGING = "\u{f089d}",
    BATTERY_40 = "\u{f007d}",
    BATTERY_40_CHARGING = "\u{f0088}",
    BATTERY_30 = "\u{f007c}",
    BATTERY_30_CHARGING = "\u{f0087}",
    BATTERY_20 = "\u{f007b}",
    BATTERY_20_CHARGING = "\u{f0086}",
    BATTERY_10 = "\u{f007a}",
    BATTERY_10_CHARGING = "\u{f089c}",
    BATTERY_0 = "\u{f008e}",
    BATTERY_0_CHARGING = "\u{f089f}",
    BATTERY_CRITICAL = "\u{f10cd}"
}

local Step = {
    [100] = { Icon.BATTERY_100, Icon.BATTERY_100_CHARGING },
    [90] = { Icon.BATTERY_90, Icon.BATTERY_90_CHARGING },
    [80] = { Icon.BATTERY_80, Icon.BATTERY_80_CHARGING },
    [70] = { Icon.BATTERY_70, Icon.BATTERY_70_CHARGING },
    [60] = { Icon.BATTERY_60, Icon.BATTERY_60_CHARGING },
    [50] = { Icon.BATTERY_50, Icon.BATTERY_50_CHARGING },
    [40] = { Icon.BATTERY_40, Icon.BATTERY_40_CHARGING },
    [30] = { Icon.BATTERY_30, Icon.BATTERY_30_CHARGING },
    [20] = { Icon.BATTERY_20, Icon.BATTERY_20_CHARGING },
    [10] = { Icon.BATTERY_10, Icon.BATTERY_10_CHARGING },
    [0] = { Icon.BATTERY_0, Icon.BATTERY_0_CHARGING }
}

local Battery = function ()
    local icon = wibox.widget.textbox()
    icon.font = "Material Design Icons 18"
    local percentage = wibox.widget.textbox()
    local layout = wibox.layout.fixed.horizontal(icon, percentage)
    layout.spacing = 4
    local container = wibox.container.margin(layout, 4, 4)
    container.visible = false
    awesome.connect_signal("battery::update", function (e)
        container.visible = e.status == 0
        if not container.visible then
            return
        end
        local capacity, status = table.unpack(e.args)
        if status == Status.UNKNOWN then
            icon.text = Icon.BATTERY_UNKNOWN
            percentage.visible = false
            return
        elseif status == Status.FULL then
            icon.text = Icon.BATTERY_FULL
            percentage.text = string.format("%s%%", capacity)
            return
        end
        capacity = tonumber(capacity)
        local index = math.floor(capacity / 10) * 10
        local discharging, charging = table.unpack(Step[index])
        icon.text = status == Status.CHARGING and charging or discharging
        percentage.text = string.format("%s%%", capacity)
    end)
    return container
end

return Battery
