local wibox = require("wibox")

local Gtk = require("user.modules.Gtk")

local Status = {
    ENABLED = "enabled",
    DISABLED = "disabled"
}

local Sunset = function ()
    local widget = wibox.widget.imagebox()
    local container = wibox.container.margin(widget, 4, 4, 4, 4)
    awesome.connect_signal("sunset::update", function (e)
        container.visible = e.status == 0
        if not container.visible then
            return
        end
        local status = table.unpack(e.args)
        if status == Status.ENABLED then
            widget.image = Gtk.lookup_icon("redshift-status-on", 16)
        else
            widget.image = Gtk.lookup_icon("redshift-status-off", 16)
        end
    end)
    return container
end

return Sunset
