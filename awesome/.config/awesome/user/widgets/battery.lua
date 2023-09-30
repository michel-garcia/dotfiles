local wibox = require("wibox")

local Gtk = require("user.modules.Gtk")

local Status = {
    CHARGING = "Charging",
    DISCHARGING = "Discharging",
    FULL = "Full",
    NOT_CHARGING = "Not charging",
    UNKNOWN = "Unknown"
}

local Battery = function ()
    local widget = wibox.widget({
        layout = wibox.container.margin,
        left = 4,
        right = 4,
        visible = false,
        {
            id = "container",
            layout = wibox.container.place,
            valign = "center",
            {
                id = "data",
                layout = wibox.layout.fixed.horizontal,
                spacing = 4,
                {
                    forced_height = 16,
                    forced_width = 16,
                    id = "icon",
                    widget = wibox.widget.imagebox
                },
                {
                    id = "percentage",
                    widget = wibox.widget.textbox
                }
            }
        }
    })
    local icon = widget.container.data.icon
    local percentage = widget.container.data.percentage
    awesome.connect_signal("battery::update", function (e)
        widget.visible = e.status == 0
        if not widget.visible then
            return
        end
        local capacity, status = table.unpack(e.args)
        if status == Status.UNKNOWN then
            icon.image = Gtk.lookup_icon("battery-missing", 16)
            percentage.visible = false
            return
        elseif status == Status.FULL then
            icon.image = Gtk.lookup_icon("battery-full", 16)
            percentage.text = string.format("%s%%", capacity)
            return
        end
        capacity = tonumber(capacity)
        local step = math.floor(capacity / 10) * 10
        local parts = { "battery", string.format("%03d", step) }
        if status == Status.CHARGING then
            table.insert(parts, "charging")
        end
        local filename = table.concat(parts, "-")
        icon.image = Gtk.lookup_icon(filename, 16)
        percentage.text = string.format("%s%%", capacity)
    end)
    return widget
end

return Battery
