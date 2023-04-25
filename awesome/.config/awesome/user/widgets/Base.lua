local wibox = require("wibox")

local Base = {}
Base.__index = Base

Base.new = function (args)
    return Base.new_with_class({}, args)
end

Base.new_with_class = function (class, args)
    local base = setmetatable(class, Base)
    local layout = wibox.layout.fixed.horizontal()
    if not args or args.icon == nil or args.icon then
        base.icon = wibox.widget.textbox()
        base.icon.font = "Material Icons"
        local margin = wibox.container.margin(base.icon)
        margin.right = 8
        layout:add(margin)
    end
    base.text = wibox.widget.textbox()
    layout:add(base.text)
    base.widget = wibox.container.margin(layout)
    base.widget.left = 8
    base.widget.right = 8
    return base
end

Base.set_icon = function (self, icon)
    if self.icon then
        self.icon:set_text(icon)
    end
end

Base.set_text = function (self, text)
    self.text:set_text(text)
end

return setmetatable(Base, {
    __call = function (_, ...)
        local base = Base.new(...)
        return base.widget
    end
})

