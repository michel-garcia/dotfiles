hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + R", hl.dsp.exec_cmd("wofi --show drun"))
hl.bind("SUPER + W", hl.dsp.window.close())
hl.bind(
    "SUPER + M",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))

hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))

for i = 1, 10 do
    local key = i % 10
    if hl.plugin.split_monitor_workspaces then
        hl.bind(string.format("SUPER + %s", key), function()
            hl.plugin.split_monitor_workspaces.workspace(i)
        end)
        hl.bind(string.format("SUPER + SHIFT + %s", key), function()
            hl.plugin.split_monitor_workspaces.move_to_workspace(i)
        end)
    else
        hl.bind(string.format("SUPER + %s", key), hl.dsp.focus({ workspace = i }))
        hl.bind(string.format("SUPER + SHIFT + %s", key), hl.dsp.window.move({ workspace = i }))
    end
end

hl.bind("SUPER + CTRL + H", hl.dsp.focus({ monitor = "-1" }))
hl.bind("SUPER + CTRL + L", hl.dsp.focus({ monitor = "+1" }))
if hl.plugin.split_monitor_workspaces then
    hl.bind("SUPER + CTRL + SHIFT + H", function()
        hl.plugin.split_monitor_workspaces.change_monitor("-1")
    end)
    hl.bind("SUPER + CTRL + SHIFT + L", function()
        hl.plugin.split_monitor_workspaces.change_monitor("+1")
    end)
end

hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("Print", hl.dsp.exec_cmd("hyprshot --mode output --mode active"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("hyprshot --mode window"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot --mode region"))

hl.bind("SUPER + F12", function()
    local handle = io.popen("pgrep -x hyprsunset")
    if not handle then
        return
    end
    local res = handle:read("*a")
    handle:close()
    if res and res:match("%d") then
        hl.exec_cmd("pkill hyprsunset")
    else
        hl.exec_cmd("hyprsunset --temperature 4000")
    end
end)
