local awful = require("awful")
local gears = require("gears")

local config = require("user.config")
local modkey = config.modkey
local terminal = config.terminal

local keys = gears.table.join(
    awful.key(
        { modkey, "Control" }, "r", function ()
            awesome.restart()
        end
    ),
    awful.key(
        { modkey, "Shift" }, "q", function ()
            awesome.quit()
        end
    ),
    awful.key(
        { modkey }, "Return", function ()
            awful.spawn(terminal)
        end
    ),
    awful.key(
        { modkey }, "p", function()
            awful.spawn("rofi -disable-history -show drun")
        end
    ),
    awful.key(
        { modkey }, "j", function ()
            awful.client.focus.byidx( 1)
        end
    ),
    awful.key(
        { modkey }, "k", function ()
            awful.client.focus.byidx(-1)
        end
    ),
    awful.key(
        { modkey, "Shift" }, "j", function ()
            awful.client.swap.byidx(1)
        end
    ),
    awful.key(
        { modkey, "Shift" }, "k", function ()
            awful.client.swap.byidx(-1)
        end
    ),
    awful.key(
        { modkey, "Control" }, "j", function ()
            awful.screen.focus_relative(1)
        end
    ),
    awful.key(
        { modkey, "Control" }, "k", function ()
            awful.screen.focus_relative(-1)
        end
    ),
    awful.key(
        { modkey }, "u", function ()
            awful.client.urgent.jumpto()
        end
    ),
    awful.key(
        { modkey }, "Tab", function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end
    ),
    awful.key(
        { modkey }, "l", function ()
            awful.tag.incmwfact(0.05)
        end
    ),
    awful.key(
        { modkey }, "h", function ()
            awful.tag.incmwfact(-0.05)
        end
    ),
    awful.key(
        { modkey, "Shift" }, "h", function ()
            awful.tag.incnmaster(1, nil, true)
        end
    ),
    awful.key(
        { modkey, "Shift" }, "l", function ()
            awful.tag.incnmaster(-1, nil, true)
        end
    ),
    awful.key(
        { modkey, "Control" }, "h", function ()
            awful.tag.incncol(1, nil, true)
        end
    ),
    awful.key(
        { modkey, "Control" }, "l", function ()
            awful.tag.incncol(-1, nil, true)
        end
    ),
    awful.key(
        { modkey }, "space", function ()
            awful.layout.inc(1)
        end
    ),
    awful.key(
        { modkey, "Shift" }, "space", function ()
            awful.layout.inc(-1)
        end
    ),
    awful.key(
        { modkey, "Control" }, "n", function ()
            local c = awful.client.restore()
            if c then
                c:emit_signal("request::activate", "key.unminimize", {
                    raise = true
                })
            end
        end
    )
)

for i = 1, 9 do
    keys = gears.table.join(keys,
        awful.key(
            { modkey }, "#" .. i + 9, function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                   tag:view_only()
                end
            end
        ),
        awful.key(
            { modkey, "Control" }, "#" .. i + 9, function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end
        ),
        awful.key(
            { modkey, "Shift" }, "#" .. i + 9, function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end
        ),
        awful.key(
            { modkey, "Control", "Shift" }, "#" .. i + 9, function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end
        )
    )
end

return keys
