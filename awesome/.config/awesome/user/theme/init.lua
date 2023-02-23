local beautiful = require("beautiful")
local naughty = require("naughty")

beautiful.init({
    bg_normal = "#282828",
    border_width = 2,
    border_normal = "#5f676a",
    border_focus = "#c78f23",
    font = "FiraCode Nerd Font Mono Bold 10",
    systray_icon_spacing = 6,
    taglist_fg_empty = "#665c54",
    taglist_fg_focus = "#fabd2f",
    taglist_fg_occupied = "#e7d7ad",
    taglist_font = "FiraCode Nerd Font Mono Bold 12",
    taglist_spacing = 4,
    useless_gap = 6
})

naughty.config.defaults.border_width = 2
naughty.config.defaults.icon_size = 48

