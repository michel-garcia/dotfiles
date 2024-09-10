from libqtile import widget

from .backlight import Backlight
from .battery import Battery
from .cpu import CPU
from .diskusage import DiskUsage
from .memory import Memory
from .pulsevolume import PulseVolume
from .wlan import Wlan


def init_widget_defaults():
    return dict(font="Ubuntu", fontsize=14, icon_theme="Papirus-Dark", padding=3)


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
            urgent_border="#fb4934",
        ),
        widget.Spacer(),
        CPU(),
        Memory(),
        DiskUsage(),
        widget.Spacer(length=8),
    ]
    return widgets


def init_top_widgets():
    widgets = [
        widget.Spacer(length=8),
        widget.GroupBox(
            active="#eee",
            block_highlight_text_color="#000",
            disable_drag=True,
            highlight_method="block",
            margin_x=0,
            other_current_screen_border="#665c54",
            other_screen_border="#665c54",
            rounded=False,
            spacing=0,
            this_current_screen_border="#fabd2f",
            this_screen_border="#fabd2f",
            urgent_alert_method="text",
            urgent_text="#fb4934",
            use_mouse_wheel=False,
        ),
        widget.Spacer(),
        widget.Clock(format="%a %b %d %H:%M:%S"),
        widget.Spacer(),
        Wlan(),
        Backlight(
            backlight_name="amdgpu_bl1",
        ),
        PulseVolume(),
        Battery(),
        widget.Spacer(length=8),
    ]
    return widgets
