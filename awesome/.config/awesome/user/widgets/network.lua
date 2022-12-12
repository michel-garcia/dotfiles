local gears = require("gears")
local wibox = require("wibox")

local widget = {}

local function get_icon(filename)
    local info = debug.getinfo(1, "S")
    local path = info.short_src
    local offset = string.len(path) - string.find(string.reverse(path), "/")
    local image = table.concat({
        string.sub(path, 0, offset),
        "icons",
        filename
    }, "/")
    return gears.color.recolor_image(image, "#fff")
end

local function worker(_)
    local imagebox = wibox.widget({
        widget = wibox.widget.imagebox,
        image = get_icon("web-sync.svg")
    })
    widget = wibox.widget({
        layout = wibox.layout.margin,
        margins = 4,
        imagebox
    })
    gears.timer({
        autostart = true,
        callback = function ()
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
                    imagebox.image = get_icon("lan.svg")
                else
                    if active_interface.strength >= 75 then
                        imagebox.image = get_icon("wifi-strength-4.svg")
                    elseif active_interface.strength >= 50 then
                        imagebox.image = get_icon("wifi-strength-3.svg")
                    elseif active_interface.strength >= 25 then
                        imagebox.image = get_icon("wifi-strength-2.svg")
                    else
                        imagebox.image = get_icon("wifi-strength-1.svg")
                    end
                end
            else
                imagebox.image = get_icon("web-cancel.svg")
            end
        end,
        timeout = 5
    })
    return widget
end

return setmetatable(widget, {
    __call = function (_, ...)
        return worker(...)
    end
})

