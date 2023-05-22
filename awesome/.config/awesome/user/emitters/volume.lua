local awful = require("awful")
local gears = require("gears")

local update = function ()
    local cmd = table.concat({
        gears.filesystem.get_configuration_dir(),
        "user/scripts/volume.py"
    }, "/")
    awful.spawn.easy_async_with_shell(cmd, function (output, _, _, status)
        awesome.emit_signal("volume::update", {
            status = status,
            args = gears.string.split(output, "\n")
        })
    end)
end

gears.timer({
    autostart = true,
    call_now = true,
    callback = function ()
        update()
    end,
    timeout = 4
})
