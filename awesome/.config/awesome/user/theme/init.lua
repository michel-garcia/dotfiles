local beautiful = require("beautiful")
local naughty = require("naughty")

local Gtk = require("user.modules.Gtk")

beautiful.init({
    bg_normal = "#0d0e0fbf",
    border_width = 2,
    border_normal = "#5f676a",
    border_focus = "#c78f23",
    font = "Ubuntu 10",
    systray_icon_spacing = 6,
    taglist_fg_empty = "#665c54",
    taglist_fg_focus = "#fabd2f",
    taglist_fg_occupied = "#e7d7ad",
    taglist_spacing = 4,
    useless_gap = 6,
    widget_icon_font = "FiraCode Nerd Font Mono Bold 18"
})

naughty.config.defaults.border_width = 1
naughty.config.defaults.icon_size = 48
naughty.config.defaults.margin = 24
naughty.config.defaults.max_width = 512
naughty.config.defaults.position = "top_middle"
naughty.config.notify_callback = function (args)
    if not args.icon then
        if args.freedesktop_hints then
            args.icon = Gtk.lookup_icon(
                args.freedesktop_hints["desktop-entry"],
                naughty.config.defaults.icon_size
            )
        end
        if not args.icon then
            args.icon = Gtk.lookup_icon(
                "application-default-icon",
                naughty.config.defaults.icon_size
            )
        end
    end
    return args
end
naughty.config.padding = 24
naughty.config.spacing = 8

