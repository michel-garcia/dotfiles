local awful = require("awful")
local beautiful = require("beautiful")
local icons = require("user.theme.icons")
local wibox = require("wibox")

local Brightness = {}
Brightness.__index = Brightness

function Brightness:new(args)
    local brightness = setmetatable({}, Brightness)
    local icon = wibox.widget.textbox()
    icon.font = beautiful.widget_icon_font
    icon.text = icons.brightness_low
    local container = wibox.container.margin(icon)
    brightness.__widget = container
    container.left = 8
    container.right = 8
    container.visible = false
    brightness:attach_tooltip(container)
    timer({
        autostart = true,
        callback = function ()
            brightness:update(icon)
        end,
        timeout = args and args.timeout or 2
    })
    brightness:update(icon)
    return brightness
end

function Brightness:attach_tooltip(widget)
    local tooltip = awful.tooltip({
        mode = "outside",
        objects = { widget },
        preferred_alignments = { "middle" }
    })
    widget:connect_signal("mouse::enter", function ()
        tooltip.text = string.format("Brightness: %s%%", self.brightness)
    end)
end

function Brightness:update(widget)
    awful.spawn.easy_async("brightnessctl get", function (output)
        self.brightness = math.ceil(tonumber(output) / 255 * 100)
        self.__widget.visible = self.brightness ~= nil
        self:refresh(widget)
    end)
    collectgarbage("collect")
end

function Brightness:refresh(widget)
    if self.brightness >= 50 then
        widget.text = icons.brightness_high
    else
        widget.text = icons.brightness_low
    end
end

return setmetatable(Brightness, {
    __call = function (_, ...)
        local brightness = Brightness:new(...)
        return brightness.__widget
    end
})

