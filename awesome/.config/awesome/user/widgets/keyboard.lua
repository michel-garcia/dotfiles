local awful = require("awful")
local icons = require("user.theme.icons")
local timer = require("gears.timer")
local wibox = require("wibox")

local Keyboard = {}
Keyboard.__index = Keyboard

Keyboard.layout = ""
Keyboard.variant = ""

function Keyboard:new(args)
    local keyboard = setmetatable({}, Keyboard)
    local icon = wibox.widget.textbox()
    icon.font = "FiraCode Nerd Font Mono 18"
    icon.text = icons.keyboard
    local spacing = wibox.container.margin()
    spacing.right = 8
    local keyboard_layout = wibox.widget.textbox()
    local layout = wibox.layout.fixed.horizontal()
    layout:add(icon)
    layout:add(spacing)
    layout:add(keyboard_layout)
    local container = wibox.container.margin(layout)
    keyboard.__widget = container
    container.left = 8
    container.right = 8
    keyboard:attach_tooltip(container)
    timer({
        autostart = true,
        callback = function ()
            keyboard:update(keyboard_layout)
        end,
        timeout = args and args.timeout or 5
    })
    keyboard:update(keyboard_layout)
    return keyboard
end

function Keyboard:attach_tooltip(widget)
    local tooltip = awful.tooltip({
        mode = "outside",
        objects = { widget },
        preferred_alignments = { "middle" }
    })
    widget:connect_signal("mouse::enter", function ()
        local entries = { self.layout }
        if self.variant then
            table.insert(entries, self.variant)
        end
        local description = table.concat(entries, " ")
        tooltip.text = string.format("Keyboard: %s", description)
    end)
end

function Keyboard:update(widget)
    awful.spawn.easy_async("setxkbmap -query", function (output)
        self.layout = output:match("layout:%s+([^\n]+)")
        self.variant = output:match("variant:%s+([^\n]+)")
        self:refresh(widget)
    end)
    collectgarbage("collect")
end

function Keyboard:refresh(widget)
    widget:set_text(self.layout)
end

return setmetatable(Keyboard, {
    __call = function (_, ...)
        local keyboard = Keyboard:new(...)
        return keyboard.__widget
    end
})

