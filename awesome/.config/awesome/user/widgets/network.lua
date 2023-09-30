local wibox = require("wibox")

local Gtk = require("user.modules.Gtk")

local Network = function()
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
                widget = wibox.widget.imagebox
            }
        }
    })
    local icon = widget.container.icon;
    awesome.connect_signal("network::update", function(e)
        widget.visible = e.status == 0
        if not widget.visible then
            return
        end
        local type, _, signal = table.unpack(e.args)
        if type == "ethernet" then
            icon.image = Gtk.lookup_icon("nm-device-wired", 16)
            return
        end
        local strength = tonumber(signal)
        if strength == 100 then
            icon.image = Gtk.lookup_icon("nm-signal-100", 16)
        elseif strength >= 75 then
            icon.image = Gtk.lookup_icon("nm-signal-75", 16)
        elseif strength >= 50 then
            icon.image = Gtk.lookup_icon("nm-signal-50", 16)
        elseif strength >= 25 then
            icon.image = Gtk.lookup_icon("nm-signal-25", 16)
        end
    end)
    return widget
end

return Network
