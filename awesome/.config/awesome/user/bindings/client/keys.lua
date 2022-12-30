local awful = require("awful")
local gears = require("gears")

local config = require("user.config")
local modkey = config.modkey

local keys = gears.table.join(
    awful.key({ modkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end
    ),
    awful.key(
        { modkey, "Shift" }, "c", function (c)
            c:kill()
        end
    ),
    awful.key(
        { modkey }, "t", function (c)
            c.floating = false
        end
    ),
    awful.key(
        { modkey, "Control" }, "Return", function (c)
            c:swap(awful.client.getmaster())
        end
    ),
    awful.key(
        { modkey }, "o", function (c)
            c:move_to_screen()
        end
    )
)

return keys

