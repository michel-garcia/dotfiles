local wibox = require("wibox")

local Icon = {
    VOLUME_HIGH = "\u{f057e}",
    VOLUME_MEDIUM = "\u{f0580}",
    VOLUME_LOW = "\u{f057f}",
    VOLUME_MUTE = "\u{f075f}"
}

local Volume = function ()
    local widget = wibox.widget.textbox()
    widget.font = "Material Design Icons 18"
    local container = wibox.container.margin(widget, 4, 4)
    awesome.connect_signal("volume::update", function (e)
        container.visible = e.status == 0
        if not container.visible then
            return
        end
        local volume, mute = table.unpack(e.args)
        volume = tonumber(volume)
        if mute == "muted" then
            widget.text = Icon.VOLUME_MUTE
        elseif volume >= 66 then
            widget.text = Icon.VOLUME_HIGH
        elseif volume >= 33 then
            widget.text = Icon.VOLUME_MEDIUM
        else
            widget.text = Icon.VOLUME_LOW
        end
    end)
    return container
end

return Volume
