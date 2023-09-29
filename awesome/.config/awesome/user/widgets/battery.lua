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
    local icon = wibox.widget.imagebox()
    local percentage = wibox.widget.textbox()
    local layout = wibox.layout.fixed.horizontal(icon, percentage)
    layout.spacing = 4
    local container = wibox.container.margin(layout, 4, 4, 4, 4)
    container.visible = false
    awesome.connect_signal("battery::update", function (e)
        container.visible = e.status == 0
        if not container.visible then
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
    return container
end

return Battery
