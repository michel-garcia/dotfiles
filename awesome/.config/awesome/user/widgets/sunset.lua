local wibox = require("wibox")

local Status = {
    ENABLED = "enabled",
    DISABLED = "disabled"
}

local Icon = {
    ENABLED = "\u{f1a4c}",
    DISABLED = "\u{f1a4d}"
}

local Sunset = function ()
    local widget = wibox.widget.textbox()
    widget.font = "Material Design Icons 18"
    local container = wibox.container.margin(widget, 4, 4)
    awesome.connect_signal("sunset::update", function (e)
        container.visible = e.status == 0
        if not container.visible then
            return
        end
        local status = table.unpack(e.args)
        if status == Status.ENABLED then
            widget.text = Icon.ENABLED
        else
            widget.text = Icon.DISABLED
        end
    end)
    return container
end

return Sunset
