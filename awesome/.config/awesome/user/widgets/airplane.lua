local wibox = require("wibox")

local Gtk = require("user.modules.Gtk")

local Status = {
    OFF = "off",
    ON = "on"
}

local Airplane = function ()
    local widget = wibox.widget.imagebox()
    widget.image = Gtk.lookup_icon("airplane-mode", 16)
    local container = wibox.container.margin(widget, 4, 4, 4, 4)
    container.visible = false
    awesome.connect_signal("airplane::update", function (e)
        if e.status ~= 0 then
            container.visible = false
            return
        end
        local status = table.unpack(e.args)
        if status == Status.ON then
            container.visible = true
        else
            container.visible = false
        end
    end)
    return container
end

return Airplane
