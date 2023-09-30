local wibox = require("wibox")

local Gtk = require("user.modules.Gtk")

local Status = {
    OFF = "off",
    ON = "on"
}

local Airplane = function ()
    local widget = wibox.widget({
        layout = wibox.container.margin,
        left = 4,
        right = 4,
        visible = false,
        {
            id = "container",
            layout =  wibox.container.place,
            valign = "center",
            {
                forced_height = 16,
                forced_width = 16,
                image = Gtk.lookup_icon("airplane-mode", 16),
                widget = wibox.widget.imagebox
            }
        }
    })
    awesome.connect_signal("airplane::update", function (e)
        if e.status ~= 0 then
            widget.visible = false
            return
        end
        local status = table.unpack(e.args)
        if status == Status.ON then
            widget.visible = true
        else
            widget.visible = false
        end
    end)
    return widget
end

return Airplane
