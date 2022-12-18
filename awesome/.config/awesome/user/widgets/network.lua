local awful = require("awful")
local timer = require("gears.timer")
local wibox = require("wibox")

local ICONS = {
    syncing = "󱞒",
    unavailable = "󱞐",
    lan = "󰌗",
    wifi = {
        low = "󰤟",
        med = "󰤢",
        high = "󰤥",
        full = "󰤨"
    }
}

local M = {}

M.device = nil
M.type = nil
M.connection = nil
M.wifi_signal = 0

function M:new(args)
    self.root = wibox.widget({
        layout = wibox.layout.margin,
        margins = 4,
        {
            widget = wibox.widget.textbox,
            id = "icon",
            font = "Material Design Icons",
            text = ICONS.syncing
        }
    })
    local tooltip = awful.tooltip({
        mode = "outside",
        objects = { M.root },
        preferred_alignments = { "middle" }
    })
    M.root:connect_signal("mouse::enter", function ()
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
    timer({
        autostart = true,
        callback = function ()
            self:update()
        end,
        timeout = args and args.timeout or 5
    })
    self:update()
    return self.root
end

function M:update()
    self:update_device_info()
    self:update_wifi_signal()
end

function M:update_device_info()
    awful.spawn.easy_async("nmcli -t device show", function (output)
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
        self:refresh()
    end)
end

function M:update_wifi_signal()
    awful.spawn.easy_async("nmcli -m multiline -t device wifi list", function (output)
        local pattern = "IN%-USE:([%*]?)\n.-SIGNAL:([%d]+)\n"
        local matches = output:gmatch(pattern)
        for in_use, signal in matches do
            if in_use == "*" then
                self.wifi_signal = tonumber(signal)
            end
        end
    end)
end

function M:refresh()
    if self.type == "ethernet" then
        self:set_icon(ICONS.lan)
    elseif self.type == "wifi" then
        local icon = self:get_wifi_icon()
        if icon then
            self:set_icon(icon)
        end
    else
        self:set_icon(ICONS.unavailable)
    end
end

function M:get_wifi_icon()
    if self.wifi_signal >= 75 then
        return ICONS.wifi.full
    elseif self.wifi_signal >= 50 then
        return ICONS.wifi.high
    elseif self.wifi_signal >= 25 then
        return ICONS.wifi.med
    elseif self.wifi_signal >= 0 then
        return ICONS.wifi.low
    end
end

function M:set_icon(icon)
    local widget = self.root:get_children_by_id("icon")[1]
    widget.text = icon
end

return setmetatable(M, {
    __call = function (_, ...)
        return M:new(...)
    end
})

