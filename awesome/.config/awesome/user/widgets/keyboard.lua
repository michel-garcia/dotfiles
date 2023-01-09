local awful = require("awful")
local timer = require("gears.timer")
local wibox = require("wibox")

local M = {}

M.layout = ""
M.variant = ""

function M:new(args)
    local widget = wibox.widget({
        layout = wibox.container.margin,
        left = 8,
        right = 8,
        {
            layout = wibox.layout.fixed.horizontal,
            {
                widget = wibox.widget.textbox,
                id = "icon",
                font = "Material Design Icons",
                text = "󰥻"
            },
            {
                widget = wibox.container.margin,
                left = 8
            },
            {
                widget = wibox.widget.textbox,
                id = "content"
            }
        }
    })
    self:attach_tooltip(widget)
    timer({
        autostart = true,
        callback = function ()
            self:update(widget)
        end,
        timeout = args and args.timeout or 5
    })
    self:update(widget)
    return widget
end

function M:attach_tooltip(widget)
    local tooltip = awful.tooltip({
        mode = "outside",
        objects = { widget },
        preferred_alignments = { "middle" }
    })
    widget:connect_signal("mouse::enter", function ()
        tooltip.text = string.format("%s %s", self.layout, self.variant)
    end)
end

function M:update(widget)
    awful.spawn.easy_async("setxkbmap -query", function (output)
        self.layout = output:match("layout:%s+([^\n]+)")
        self.variant = output:match("variant:%s+([^\n]+)")
        self:refresh(widget)
    end)
    collectgarbage("collect")
end

function M:refresh(widget)
    local content = widget:get_children_by_id("content")[1]
    content.text = self.layout
end

return setmetatable(M, {
    __call = function (_, ...)
        return M:new(...)
    end
})

