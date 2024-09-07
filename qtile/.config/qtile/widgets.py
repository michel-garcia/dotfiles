from libqtile import widget


def init_widget_defaults():
    return dict(
        font="Ubuntu",
        fontsize=14,
        padding=3
    )

def init_bottom_widgets():
    widgets = [
        widget.Spacer(length=4),
        widget.TaskList(
            border="#fabd2f",
            foreground="#eee",
            highlight_method="block",
            markup_focused="<span foreground='#000'>{}</span>",
            max_title_width=256,
            rounded=False,
            txt_floating="",
            txt_maximized="",
            txt_minimized="",
            urgent_border="#fb4934"
        ),
        widget.Spacer(),
        widget.Memory(
            format="<span size='140%'>󰍛</span>    <span baseline_shift='1.5pt'>{MemUsed:.1f}{mm}/{MemTotal:.1f}{mm}</span>",
            measure_mem="G"
        ),
        widget.Spacer(length=4),
        widget.DF(
            foreground="#eee",
            format="<span size='140%'>󰋊</span>    <span baseline_shift='1.5pt'>{f}G/{s}G</span>",
            visible_on_warn=False,
            warn_color="#fb4934"
        ),
        widget.Spacer(length=8)
    ]
    return widgets

def init_top_widgets():
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
        widget.Backlight(
            backlight_name="amdgpu_bl1",
            format="<span size='140%'>󰃠</span>    <span baseline_shift='1.5pt'>{percent:2.0%}</span>",
        ),
        widget.Spacer(length=4),
        widget.PulseVolume(
            mute_format="<span size='140%'>󰝟</span>   <span baseline_shift='1.5pt'>{volume}%</span>",
            unmute_format="<span size='140%'>󰕾</span>   <span baseline_shift='1.5pt'>{volume}%</span>"
        ),
        widget.Spacer(length=4),
        widget.Battery(
            charge_char="󰂄",
            discharge_char="󰁾",
            empty_char="󰂎",
            format="<span size='140%'>{char}</span>  <span baseline_shift='1.5pt'>{percent:2.0%}</span>",
            full_char="󰁹",
            not_charging_char="󰁾",
            markup=True,
            unknown_char="󱉝",
            show_short_text=False
        ),
        widget.Spacer(length=4)
    ]
    return widgets
