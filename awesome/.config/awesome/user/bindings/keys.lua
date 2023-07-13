local awful = require("awful")
local gears = require("gears")

local config = require("user.config")
local mod_mask = config.keys.mod
local terminal = config.apps.terminal

local Maim = require("user.modules.Maim")

local keys = {
    global = gears.table.join(
        awful.key({ mod_mask, "Control" }, "r", function ()
            awesome.restart()
        end),
        awful.key({ mod_mask, "Shift" }, "q", function ()
            awesome.quit()
        end),
        awful.key({ mod_mask }, "Return", function ()
            awful.spawn(terminal)
        end),
        awful.key({ mod_mask , "Shift" }, "Return", function ()
            local s = awful.screen.focused()
            local height = s.workarea.height / 2
            local width = s.workarea.width / 2
            awful.spawn(terminal, {
                floating = true,
                height = height,
                ontop = true,
                placement = awful.placement.centered,
                x = s.workarea.width / 2 - width / 2,
                width = width,
                y = s.workarea.height / 2 - height / 2
            })
        end),
        awful.key({ mod_mask }, "p", function()
            awful.spawn("rofi -show drun")
        end),
        awful.key({ mod_mask }, "j", function ()
            awful.client.focus.byidx(1)
        end),
        awful.key({ mod_mask }, "k", function ()
            awful.client.focus.byidx(-1)
        end),
        awful.key({ mod_mask, "Shift" }, "j", function ()
            awful.client.swap.byidx(1)
        end),
        awful.key({ mod_mask, "Shift" }, "k", function ()
            awful.client.swap.byidx(-1)
        end),
        awful.key({ mod_mask, "Control" }, "j", function ()
            awful.screen.focus_relative(1)
        end),
        awful.key({ mod_mask, "Control" }, "k", function ()
            awful.screen.focus_relative(-1)
        end),
        awful.key({ mod_mask }, "u", function ()
            awful.client.urgent.jumpto()
        end),
        awful.key({ mod_mask }, "Tab", function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
        awful.key({ mod_mask }, "l", function ()
            awful.tag.incmwfact(0.05)
        end),
        awful.key({ mod_mask }, "h", function ()
            awful.tag.incmwfact(-0.05)
        end),
        awful.key({ mod_mask, "Shift" }, "h", function ()
            awful.tag.incnmaster(1, nil, true)
        end),
        awful.key({ mod_mask, "Shift" }, "l", function ()
            awful.tag.incnmaster(-1, nil, true)
        end),
        awful.key({ mod_mask, "Control" }, "h", function ()
            awful.tag.incncol(1, nil, true)
        end),
        awful.key({ mod_mask, "Control" }, "l", function ()
            awful.tag.incncol(-1, nil, true)
        end),
        awful.key({ mod_mask }, "space", function ()
            awful.layout.inc(1)
        end),
        awful.key({ mod_mask, "Shift" }, "space", function ()
            awful.layout.inc(-1)
        end),
        awful.key({ mod_mask, "Control" }, "n", function ()
            local c = awful.client.restore()
            if c then
                c:emit_signal("request::activate", "key.unminimize", {
                    raise = true
                })
            end
        end),
        awful.key({ mod_mask }, "Pause", function ()
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
            Maim.capture_display()
        end),
        awful.key({ "Mod1" }, "Print", function ()
            Maim.capture_focused_window()
        end),
        awful.key({ "Shift" }, "Print", function ()
            Maim.capture_selection()
        end)
    ),
    client = gears.table.join(
        awful.key({ mod_mask }, "f", function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end),
        awful.key({ mod_mask, "Shift" }, "c", function (c)
            c:kill()
        end),
        awful.key({ mod_mask }, "t", function (c)
            c.floating = false
        end),
        awful.key({ mod_mask, "Control" }, "Return", function (c)
            c:swap(awful.client.getmaster())
        end),
        awful.key({ mod_mask }, "o", function (c)
            c:move_to_screen()
        end)
    )
}

for i = 1, 9 do
    keys.global = gears.table.join(keys.global,
        awful.key({ mod_mask }, "#" .. i + 9, function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
               tag:view_only()
            end
        end),
        awful.key({ mod_mask, "Control" }, "#" .. i + 9, function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end),
        awful.key({ mod_mask, "Shift" }, "#" .. i + 9, function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end),
        awful.key({ mod_mask, "Control", "Shift" }, "#" .. i + 9, function ()
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
