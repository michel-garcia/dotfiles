local awful = require("awful")
local gears = require("gears")

local config = require("user.config")
local mod_mask = config.keys.mod

local buttons = {
    global = gears.table.join(),
    client = gears.table.join(
        awful.button({}, 1, function (c)
            c:emit_signal("request::activate", "mouse_click", {
                raise = true
            })
        end),
        awful.button({ mod_mask }, 1, function (c)
            c:emit_signal("request::activate", "mouse_click", {
                raise = true
            })
            awful.mouse.client.move(c)
            local geometry = c:geometry()
            c.floating = true
            c:geometry(geometry)
        end),
        awful.button({ mod_mask }, 3, function (c)
            c:emit_signal("request::activate", "mouse_click", {
                raise = true
            })
            awful.mouse.client.resize(c)
        end)
    )
}

return buttons
