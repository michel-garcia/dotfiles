local wibox = require("wibox")

local Gtk = require("user.modules.Gtk")

local Network = function ()
    local widget = wibox.widget.imagebox()
    local container = wibox.container.margin(widget, 4, 4, 4, 4)
    awesome.connect_signal("network::update", function (e)
        container.visible = e.status == 0
        if not container.visible then
            return
        end
        local type, _, signal = table.unpack(e.args)
        if type == "ethernet" then
            widget.image = Gtk.lookup_icon("nm-device-wired", 16)
            return
        end
        local strength = tonumber(signal)
        if strength == 100 then
            widget.image = Gtk.lookup_icon("nm-signal-100", 16)
        elseif strength >= 75 then
            widget.image = Gtk.lookup_icon("nm-signal-75", 16)
        elseif strength >= 50 then
            widget.image = Gtk.lookup_icon("nm-signal-50", 16)
        elseif strength >= 25 then
            widget.image = Gtk.lookup_icon("nm-signal-25", 16)
        end
    end)
    return container
end

return Network
