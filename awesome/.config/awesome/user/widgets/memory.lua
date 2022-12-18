local timer = require("gears.timer")
local wibox = require("wibox")

local M = {}

function M:new(args)
    self.widget = wibox.widget({
        layout = wibox.layout.fixed.horizontal,
        {
            widget = wibox.widget.textbox,
            font = "Material Design Icons",
            id = "icon",
            text = "󰍛"
        },
        {
            widget = wibox.container.margin,
            margins = 2
        },
        {
            widget = wibox.widget.textbox,
            id = "percentage"
        }
    })
    timer({
        autostart = true,
        callback = function ()
            self:update()
        end,
        timeout = args and args.timeout or 5
    })
    self:update()
    return self.widget
end

function M:update()
    local handle = io.popen("cat /proc/meminfo")
    if handle then
        local info = {}
        for line in handle:lines() do
            local key, value = line:match("([%a]+):[%s]+([%d]+)")
            if key then
                info[key] = value
            end
        end
        handle:close()
        local total = info["MemTotal"]
        local free = info["MemFree"]
        local buffers = info["Buffers"]
        local cached = info["Cached"]
        local reclaimable = info["SReclaimable"]
        local used = total - free - buffers - cached - reclaimable
        self:set_percentage(math.floor(used / total * 100))
    end
end

function M:set_percentage(value)
    local widget = self.widget:get_children_by_id("percentage")[1]
    widget:set_text(string.format("%s%%", value))
end

return setmetatable(M, {
    __call = function (_, ...)
        return M:new(...)
    end
})

