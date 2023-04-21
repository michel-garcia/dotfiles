local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

local config = require("user.config")
local utils = require("user.theme.utils")
local modkey = config.modkey
local terminal = config.terminal

local keys = {
    global = gears.table.join(
        awful.key({ modkey, "Control" }, "r", function ()
            awesome.restart()
        end),
        awful.key({ modkey, "Shift" }, "q", function ()
            awesome.quit()
        end),
        awful.key({ modkey }, "Return", function ()
            awful.spawn(terminal)
        end),
        awful.key({ modkey }, "p", function()
            awful.spawn("rofi -show drun")
        end),
        awful.key({ modkey }, "j", function ()
            awful.client.focus.byidx(1)
        end),
        awful.key({ modkey }, "k", function ()
            awful.client.focus.byidx(-1)
        end),
        awful.key({ modkey, "Shift" }, "j", function ()
            awful.client.swap.byidx(1)
        end),
        awful.key({ modkey, "Shift" }, "k", function ()
            awful.client.swap.byidx(-1)
        end),
        awful.key({ modkey, "Control" }, "j", function ()
            awful.screen.focus_relative(1)
        end),
        awful.key({ modkey, "Control" }, "k", function ()
            awful.screen.focus_relative(-1)
        end),
        awful.key({ modkey }, "u", function ()
            awful.client.urgent.jumpto()
        end),
        awful.key({ modkey }, "Tab", function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
        awful.key({ modkey }, "l", function ()
            awful.tag.incmwfact(0.05)
        end),
        awful.key({ modkey }, "h", function ()
            awful.tag.incmwfact(-0.05)
        end),
        awful.key({ modkey, "Shift" }, "h", function ()
            awful.tag.incnmaster(1, nil, true)
        end),
        awful.key({ modkey, "Shift" }, "l", function ()
            awful.tag.incnmaster(-1, nil, true)
        end),
        awful.key({ modkey, "Control" }, "h", function ()
            awful.tag.incncol(1, nil, true)
        end),
        awful.key({ modkey, "Control" }, "l", function ()
            awful.tag.incncol(-1, nil, true)
        end),
        awful.key({ modkey }, "space", function ()
            awful.layout.inc(1)
        end),
        awful.key({ modkey, "Shift" }, "space", function ()
            awful.layout.inc(-1)
        end),
        awful.key({ modkey, "Control" }, "n", function ()
            local c = awful.client.restore()
            if c then
                c:emit_signal("request::activate", "key.unminimize", {
                    raise = true
                })
            end
        end),
        awful.key({ modkey }, "Pause", function ()
            awful.spawn.with_shell("sleep 1; xset dpms force off")
        end),
        awful.key({}, "XF86MonBrightnessDown", function ()
            awful.spawn.with_shell("brightnessctl set 10%-")
        end),
        awful.key({}, "XF86MonBrightnessUp", function ()
            awful.spawn.with_shell("brightnessctl set +10%")
        end),
        awful.key({}, "XF86AudioPrev", function ()
            awful.spawn.with_shell("playerctl previous")
        end),
        awful.key({}, "XF86AudioPlay", function ()
            awful.spawn.with_shell("playerctl play-pause")
        end),
        awful.key({}, "XF86AudioNext", function ()
            awful.spawn.with_shell("playerctl next")
        end),
        awful.key({}, "XF86AudioMute", function ()
            awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle")
        end),
        awful.key({}, "XF86AudioLowerVolume", function ()
            awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%")
        end),
        awful.key({}, "XF86AudioRaiseVolume", function ()
            awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%")
        end),
        awful.key({}, "Print", function ()
            local filename = string.format(
                "~/Pictures/%s.png",
                os.date("%Y%m%d_%H%M%S")
            )
            local command = string.format("maim %s", filename)
            awful.spawn.easy_async_with_shell(command, function (_, _, _, exit_code)
                if exit_code == 0 then
                    naughty.notify({
                        icon = utils.get_icon("screenshot-app", 48),
                        text = string.format("Screenshot saved to '%s'", filename),
                        title = "Screenshot taken"
                    })
                end
            end)
        end),
        awful.key({ "Mod1" }, "Print", function ()
            local filename = string.format(
                "~/Pictures/%s.png",
                os.date("%Y%m%d_%H%M%S")
            )
            local command = string.format(
                "maim --window $(xdotool getactivewindow) %s",
                filename
            )
            awful.spawn.easy_async_with_shell(command, function (_, _, _, exit_code)
                if exit_code == 0 then
                    naughty.notify({
                        icon = utils.get_icon("screenshot-app", 48),
                        text = string.format("Screenshot saved to '%s'", filename),
                        title = "Screenshot taken"
                    })
                end
            end)
        end),
        awful.key({ "Shift" }, "Print", function ()
            local filename = string.format(
                "~/Pictures/%s.png",
                os.date("%Y%m%d_%H%M%S")
            )
            local command = string.format("maim --select %s", filename)
            awful.spawn.easy_async_with_shell(command, function (_, _, _, exit_code)
                if exit_code == 0 then
                    naughty.notify({
                        icon = utils.get_icon("screenshot-app", 48),
                        text = string.format("Screenshot saved to '%s'", filename),
                        title = "Screenshot taken"
                    })
                end
            end)
        end)
    ),
    client = gears.table.join(
        awful.key({ modkey }, "f", function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end),
        awful.key({ modkey, "Shift" }, "c", function (c)
            c:kill()
        end),
        awful.key({ modkey }, "t", function (c)
            c.floating = false
        end),
        awful.key({ modkey, "Control" }, "Return", function (c)
            c:swap(awful.client.getmaster())
        end),
        awful.key({ modkey }, "o", function (c)
            c:move_to_screen()
        end)
    )
}

for i = 1, 9 do
    keys.global = gears.table.join(keys.global,
        awful.key({ modkey }, "#" .. i + 9, function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
               tag:view_only()
            end
        end),
        awful.key({ modkey, "Control" }, "#" .. i + 9, function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end)
    )
end

return keys
