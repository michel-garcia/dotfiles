local awful = require("awful")
local beautiful = require("beautiful")

local keys = require("user.bindings.client.keys")
local buttons = require("user.bindings.client.buttons")

awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            buttons = buttons,
            focus = awful.client.focus.filter,
            keys = keys,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            raise = true,
            screen = awful.screen.preferred
        }
    },
    {
        rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "gnome-calculator",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Nitrogen",
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester",  -- xev.
                "Steam - News",
                "Friends List"
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            },
            type = {
                "dialog"
            }
        },
        properties = {
            floating = true,
            placement = awful.placement.centered
        }
    }
}

