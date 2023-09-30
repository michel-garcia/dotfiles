local wibox = require("wibox")

local Gtk = require("user.modules.Gtk")

local Status = {
    ENABLED = "enabled",
    DISABLED = "disabled"
}

local Sunset = function ()
    local widget = wibox.widget({
        layout = wibox.container.margin,
        left = 4,
        right = 4,
        {
            id = "container",
            layout = wibox.container.place,
            valign = "center",
            {
                forced_height = 16,
                forced_width = 16,
                id = "icon",
                image = Gtk.lookup_icon("redshift-status-on", 16),
                widget = wibox.widget.imagebox
            }
        }
    })
    awesome.connect_signal("sunset::update", function (e)
        widget.visible = e.status == 0
        if not widget.visible then
            return
        end
        local status = table.unpack(e.args)
        widget.visible = status == Status.ENABLED
    end)
    return widget
end

return Sunset
