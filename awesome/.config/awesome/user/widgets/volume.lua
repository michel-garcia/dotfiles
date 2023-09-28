local wibox = require("wibox")

local Gtk = require("user.modules.Gtk")

local Volume = function ()
    local widget = wibox.widget.imagebox()
    local container = wibox.container.margin(widget, 4, 4, 4, 4)
    awesome.connect_signal("volume::update", function (e)
        container.visible = e.status == 0
        if not container.visible then
            return
        end
        local volume, mute = table.unpack(e.args)
        volume = tonumber(volume)
        if mute == "muted" then
            widget.image = Gtk.lookup_icon("audio-volume-muted", 16)
        elseif volume >= 66 then
            widget.image = Gtk.lookup_icon("audio-volume-high", 16)
        elseif volume >= 33 then
            widget.image = Gtk.lookup_icon("audio-volume-medium", 16)
        else
            widget.image = Gtk.lookup_icon("audio-volume-low", 16)
        end
    end)
    return container
end

return Volume
