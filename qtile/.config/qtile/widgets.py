from libqtile import widget

from colors import colors


def init_widget_defaults():
    return dict(
        font="Ubuntu",
        fontsize=14,
        padding=3
    )

def init_widgets():
    widgets = [
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
            format="{location_city}: {main_feels_like} °{units_temperature} {weather_details}",
            location="Miami"
        ),
        widget.Spacer(),
        widget.Battery(),
    ]
    return widgets
