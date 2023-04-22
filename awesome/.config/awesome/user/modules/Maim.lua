local awful = require("awful")
local naughty = require("naughty")

local generate_filename = function ()
    return string.format("~/Pictures/%s.png", os.date("%Y%m%d_%H%M%S"))
end

local notify = function (filename)
    naughty.notify({
        text = string.format("Screenshot saved to '%s'", filename),
        title = "Screenshot taken"
    })
end

local Maim = {}

Maim.capture_display = function ()
    local filename = generate_filename()
    local cmd = string.format("maim %s", filename)
    awful.spawn.easy_async_with_shell(cmd, function (_, _, _, exit_code)
        if exit_code == 0 then
            notify(filename)
        end
    end)
end

Maim.capture_focused_window = function ()
    local filename = generate_filename()
    local cmd = string.format(
        "maim --window $(xdotool getactivewindow) %s",
        filename
    )
    awful.spawn.easy_async_with_shell(cmd, function (_, _, _, exit_code)
        if exit_code == 0 then
            notify(filename)
        end
    end)
end

Maim.capture_selection = function ()
    local filename = generate_filename()
    local cmd = string.format("maim --select %s", filename)
    awful.spawn.easy_async_with_shell(cmd, function (_, _, _, exit_code)
        if exit_code == 0 then
            notify(filename)
        end
    end)
end

return Maim
