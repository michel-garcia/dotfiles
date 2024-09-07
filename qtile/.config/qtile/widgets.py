from libqtile import widget


def init_widget_defaults():
    return dict(
        font="Ubuntu",
        fontsize=14,
        padding=3
    )

def init_widgets():
    widgets = [
        widget.GroupBox(
            active="#eee",
            disable_drag=True,
            highlight_method="text",
            other_current_screen_border="#665c54",
            other_screen_border="#665c54",
            rounded=False,
            spacing=0,
            this_current_screen_border="#fabd2f",
            this_screen_border="#fabd2f",
            urgent_alert_method="text",
            urgent_text="#fb4934",
            use_mouse_wheel=False
        ),
        widget.Spacer(),
        widget.Clock(format="%a %b %d %H:%M:%S"),
        widget.Spacer(),
        widget.Battery(),
    ]
    return widgets
