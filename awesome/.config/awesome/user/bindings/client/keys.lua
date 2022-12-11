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
    ),
    awful.key(
        { modkey }, "t", function (c)
            c.ontop = not c.ontop
        end
    ),
    awful.key(
        { modkey }, "n", function (c)
            c.minimized = true
        end
    ),
    awful.key(
        { modkey }, "m", function (c)
            c.maximized = not c.maximized
            c:raise()
        end
    ),
    awful.key(
        { modkey, "Control" }, "m", function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end
    ),
    awful.key(
        { modkey, "Shift" }, "m", function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end
    )
)

return keys

