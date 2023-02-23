local awful = require("awful")
local icons = require("user.theme.icons")
local timer = require("gears.timer")
local wibox = require("wibox")

local Network = {}
Network.__index = Network

Network.device = nil
Network.type = nil
Network.connection = nil
Network.wifi_signal = 0

function Network:new(args)
    local network = setmetatable({}, Network)
    local icon = wibox.widget.textbox()
    icon.font = "FiraCode Nerd Font Mono 18"
    icon.text = icons.network_unavailable
    local container = wibox.container.margin(icon)
    network.__widget = container
    container.left = 8
    container.right = 8
    network:attach_tooltip(container)
    timer({
        autostart = true,
        callback = function ()
            network:update(icon)
        end,
        timeout = args and args.timeout or 1
    })
    network:update(icon)
    return network
end

function Network:attach_tooltip(widget)
    local tooltip = awful.tooltip({
        mode = "outside",
        objects = { widget },
        preferred_alignments = { "middle" }
    })
    widget:connect_signal("mouse::enter", function ()
        if self.connection then
            if self.type == "ethernet" then
                tooltip.text = string.format("Ethernet: %s", self.connection)
            elseif self.type == "wifi" then
                tooltip.text = string.format("%s: %s%%", self.connection, self.wifi_signal)
            else
                tooltip.text = "No Internet"
            end
        end
    end)
end

function Network:update(widget)
    self:update_device_info(function ()
        self:refresh(widget)
    end)
    self:update_wifi_signal(function ()
        self:refresh(widget)
    end)
    collectgarbage("collect")
end

function Network:update_device_info(callback)
    awful.spawn.easy_async("nmcli --terse device show", function (output)
        local pattern = table.concat({
            "GENERAL.DEVICE:(.-)\n.-",
            "GENERAL.TYPE:(.-)\n.-",
            "GENERAL.STATE:(.-)\n.-",
            "GENERAL.CONNECTION:(.-)\n"
        })
        local matches = output:gmatch(pattern)
        local devices = {}
        for name, type, state, connection in matches do
            local device = {
                name = name,
                type = type,
                connection = connection,
                state = state
            }
            table.insert(devices, device)
        end
        local preferred = nil
        for _, device in ipairs(devices) do
            if device.state:match("%d+") == "100" then
                if not preferred or device.type == "ethernet" then
                    preferred = device
                end
            end
        end
        self.device = preferred and preferred.name or nil
        self.type = preferred and preferred.type or nil
        self.connection = preferred and preferred.connection or nil
        if callback then
            callback()
        end
    end)
end

function Network:update_wifi_signal(callback)
    awful.spawn.easy_async("nmcli --mode multiline --terse device wifi list", function (output)
        local pattern = "IN%-USE:([%*]?)\n.-SIGNAL:([%d]+)\n"
        local matches = output:gmatch(pattern)
        for in_use, signal in matches do
            if in_use == "*" then
                self.wifi_signal = tonumber(signal)
                if callback then
                    callback()
                end
                return
            end
        end
    end)
end

function Network:refresh(widget)
    if self.type == "ethernet" then
        widget.text = icons.ethernet
    elseif self.type == "wifi" then
        if self.wifi_signal == 100 then
            widget.text = icons.wifi_strength_4
        elseif self.wifi_signal >= 80 then
            widget.text = icons.wifi_strength_3
        elseif self.wifi_signal >= 40 then
            widget.text = icons.wifi_strength_2
        else
            widget.text = icons.wifi_strength_1
        end
    else
        widget.text = icons.network_unavailable
    end
end

return setmetatable(Network, {
    __call = function (_, ...)
        local network = Network:new(...)
        return network.__widget
    end
})

