local wibox = require("wibox")

local Icon = {
    OFF = "\u{f001e}",
    ON = "\u{f001d}"
}

local Status = {
    OFF = "off",
    ON = "on"
}

local Airplane = function ()
    local widget = wibox.widget.textbox()
    widget.font = "Material Design Icons 18"
    local container = wibox.container.margin(widget, 4, 4)
    container.visible = false
    awesome.connect_signal("airplane::update", function (e)
        if e.status ~= 0 then
            container.visible = false
            return
        end
        local status = table.unpack(e.args)
        if status == Status.ON then
            widget.text = Icon.ON
            container.visible = true
        else
            widget.text = Icon.OFF
            container.visible = false
        end
    end)
    return container
end

return Airplane
