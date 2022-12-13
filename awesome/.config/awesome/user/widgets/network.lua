local timer = require("gears.timer")
local wibox = require("wibox")

local M = {}

function M:new(args)
    self.icons = args and args.icons or {
        syncing = "󱞒",
        unavailable = "󱞐",
        lan = "󰌗",
        wifi_low = "󰤟",
        wifi_med = "󰤢",
        wifi_high = "󰤥",
        wifi_full = "󰤨"
    }
    self.widget = wibox.widget({
        layout = wibox.layout.margin,
        margins = 4,
        {
            widget = wibox.widget.textbox,
            id = "icon",
            font = "Material Design Icons",
            text = self.icons.syncing
        }
    })
    timer({
        autostart = true,
        callback = function ()
            self:update()
        end,
        timeout = args and args.timeout or 1
    })
    self:update()
    return self.widget
end

function M:update()
    local active_interface = nil
    local name_handle = io.popen("ls /sys/class/net")
    if name_handle then
        for name in name_handle:lines() do
            local interface = {
                name = name,
                connected = false,
                wireless = false,
                strength = -1
            }
            local state_handle = io.popen(string.format(
                "cat /sys/class/net/%s/operstate",
                name
            ))
            if state_handle then
                local output = state_handle:read("*a")
                local state = output:gsub("[\n\r]", "")
                interface.connected = state == "up"
                state_handle:close()
            end
            if interface.connected then
                local wireless_handle = io.popen(string.format(
                    "ls /sys/class/net/%s/wireless",
                    name
                ))
                if wireless_handle then
                    interface.wireless = wireless_handle:close() or false
                end
                if interface.wireless and interface.connected then
                    local signal_handle = io.popen("nmcli -t -f IN-USE,SIGNAL device wifi list | grep '^*'")
                    if signal_handle then
                        local output = signal_handle:read("*a")
                        local strength = output:gsub("^*:", ""):gsub("[\n\r]", "")
                        interface.strength = strength
                        signal_handle:close()
                    end
                end
                if not active_interface then
                    active_interface = interface
                elseif not interface.wireless then
                    active_interface = interface
                end
            end
        end
        name_handle:close()
    end
    if active_interface then
        if not active_interface.wireless then
            self:set_icon(self.icons.lan)
        else
            if active_interface.strength >= 75 then
                self:set_icon(self.icons.wifi_full)
            elseif active_interface.strength >= 50 then
                self:set_icon(self.icons.wifi_high)
            elseif active_interface.strength >= 25 then
                self:set_icon(self.icons.wifi_med)
            else
                self:set_icon(self.icons.wifi_low)
            end
        end
    else
        self:set_icon(self.icons.unavailable)
    end
end

function M:set_icon(icon)
    local widget = table.remove(self.widget:get_children_by_id("icon"))
    widget.text = icon
end

return setmetatable(M, {
    __call = function (_, ...)
        return M:new(...)
    end
})

