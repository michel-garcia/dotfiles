local wibox = require("wibox")

local Status = {
    ACTIVE = "active",
    INACTIVE = "inactive"
}

local Icon = {
    ACTIVE = "\u{f1a4c}",
    INACTIVE = "\u{f1a4d}"
}

local Redshift = function ()
    local widget = wibox.widget.textbox()
    widget.font = "Material Design Icons 18"
    local container = wibox.container.margin(widget, 4, 4)
    awesome.connect_signal("redshift::update", function (e)
        container.visible = e.status == 0
        if not container.visible then
            return
        end
        local status = table.unpack(e.args)
        if status == Status.ACTIVE then
            widget.text = Icon.ACTIVE
        else
            widget.text = Icon.INACTIVE
        end
    end)
    return container
end

return Redshift
