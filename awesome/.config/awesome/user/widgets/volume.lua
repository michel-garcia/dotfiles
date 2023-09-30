local wibox = require("wibox")

local Gtk = require("user.modules.Gtk")

local Volume = function ()
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
    local icon = widget.container.icon
    awesome.connect_signal("volume::update", function (e)
        widget.visible = e.status == 0
        if not widget.visible then
            return
        end
        local volume, mute = table.unpack(e.args)
        volume = tonumber(volume)
        if mute == "muted" then
            icon.image = Gtk.lookup_icon("audio-volume-muted", 16)
        elseif volume >= 66 then
            icon.image = Gtk.lookup_icon("audio-volume-high", 16)
        elseif volume >= 33 then
            icon.image = Gtk.lookup_icon("audio-volume-medium", 16)
        else
            icon.image = Gtk.lookup_icon("audio-volume-low", 16)
        end
    end)
    return widget
end

return Volume
