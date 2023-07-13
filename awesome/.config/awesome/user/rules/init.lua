local awful = require("awful")
local beautiful = require("beautiful")

local keys = require("user.bindings.keys")
local buttons = require("user.bindings.buttons")

awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            buttons = buttons.client,
            floating = true,
            focus = awful.client.focus.filter,
            keys = keys.client,
            ontop = true,
            placement = function (c)
                awful.placement.centered(c, {
                    parent = c.transient_for
                })
                awful.placement.no_offscreen(c)
            end,
            raise = true,
            screen = awful.screen.preferred,
            size_hints_honor = true
        }
    },
    {
        rule_any = {
            class = {
                "firefox",
                "kitty"
            }
        },
        except = {
            type = "dialog"
        },
        properties = {
            floating = false,
            ontop = false,
            size_hints_honor = false
        }
    }
}

