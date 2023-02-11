local awful = require("awful")
local timer = require("gears.timer")
local wibox = require("wibox")

local M = {}

local ICON_UNAVAILABLE = "\u{f1405}"
local ICON_LAN = "\u{f0318}"
local ICON_WIFI_STRENGTH_1 = "\u{f091f}"
local ICON_WIFI_STRENGTH_2 = "\u{f0922}"
local ICON_WIFI_STRENGTH_3 = "\u{f0925}"
local ICON_WIFI_STRENGTH_4 = "\u{f0928}"

M.device = nil
M.type = nil
M.connection = nil
M.wifi_signal = 0

function M:new(args)
    local widget = wibox.widget({
        layout = wibox.layout.margin,
        left = 8,
        right = 8,
        {
            widget = wibox.widget.textbox,
            font = "FiraCode Nerd Font Mono 14",
            id = "icon",
            text = ICON_LAN
        }
    })
    self:attach_tooltip(widget)
    timer({
        autostart = true,
        callback = function ()
            self:update(widget)
        end,
        timeout = args and args.timeout or .2
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

function M:update(widget)
    self:update_device_info(function ()
        self:refresh(widget)
    end)
    self:update_wifi_signal(function ()
        self:refresh(widget)
    end)
    collectgarbage("collect")
end

function M:update_device_info(callback)
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

function M:update_wifi_signal(callback)
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

function M:refresh(widget)
    local icon = table.unpack(widget:get_children_by_id("icon"))
    if self.type == "ethernet" then
        icon:set_text(ICON_LAN)
    elseif self.type == "wifi" then
        if self.wifi_signal >= 75 then
            icon:set_text(ICON_WIFI_STRENGTH_4)
        elseif self.wifi_signal >= 50 then
            icon:set_text(ICON_WIFI_STRENGTH_3)
        elseif self.wifi_signal >= 25 then
            icon:set_text(ICON_WIFI_STRENGTH_2)
        else
            icon:set_text(ICON_WIFI_STRENGTH_1)
        end
    else
        icon:set_text(ICON_UNAVAILABLE)
    end
end

return setmetatable(M, {
    __call = function (_, ...)
        return M:new(...)
    end
})

