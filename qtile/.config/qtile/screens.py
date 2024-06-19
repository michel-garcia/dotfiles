from libqtile import bar, widget
from libqtile.config import Screen
from qtile_extras import widget as extra_widget

from colors import colors

screens = [
    Screen(
        bottom=bar.Gap(4),
        left=bar.Gap(4),
        right=bar.Gap(4),
        top=bar.Bar(
            [
                widget.GroupBox(
                    disable_drag=True,
                    hide_unused=True,
                    highlight_method="block",
                    other_current_screen_border="#665c54",
                    other_screen_border="#665c54",
                    rounded=False,
                    spacing=0,
                    this_current_screen_border=colors["primary"],
                    this_screen_border=colors["primary"],
                    use_mouse_wheel=False
                ),
                widget.Spacer(),
                widget.Clock(format="%a %b %d %H:%M:%S"),
                widget.OpenWeather(
                    format="{location_city}: {main_feels_like} °{units_temperature} {icon} {weather_details}",
                    location="Miami"
                ),
                widget.Spacer(),
                extra_widget.StatusNotifier(
                    highlight_colour=colors["primary"],
                    highlight_radius=0
                ),
                widget.Battery(),
            ],
            background="#000",
            margin=[0, 0, 4, 0],
            size=32,
        ),
    ) for _ in range(3)
]
