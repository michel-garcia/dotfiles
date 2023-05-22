local wibox = require("wibox")

local Icon = {
    ETHERNET = "\u{f0200}",
    WIFI_SIGNAL_100 = "\u{f0928}",
    WIFI_SIGNAL_75 = "\u{f0925}",
    WIFI_SIGNAL_50 = "\u{f0922}",
    WIFI_SIGNAL_25 = "\u{f091f}",
    WIFI_SIGNAL_0 = "\u{f092f}"
}

local Network = function ()
    local widget = wibox.widget.textbox()
    widget.font = "Material Design Icons 18"
    local container = wibox.container.margin(widget, 4, 4)
    awesome.connect_signal("network::update", function (e)
        container.visible = e.status == 0
        if not container.visible then
            return
        end
        local type, _, signal = table.unpack(e.args)
        if type == "ethernet" then
            widget.text = Icon.ETHERNET
            return
        end
        signal = tonumber(signal)
        if signal == 100 then
            widget.text = Icon.WIFI_SIGNAL_100
        elseif signal >= 75 then
            widget.text = Icon.WIFI_SIGNAL_75
        elseif signal >= 50 then
            widget.text = Icon.WIFI_SIGNAL_50
        elseif signal >= 25 then
            widget.text = Icon.WIFI_SIGNAL_25
        else
            widget.text = Icon.WIFI_SIGNAL_0
        end
    end)
    return container
end

return Network
