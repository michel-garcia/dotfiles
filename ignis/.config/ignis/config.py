from ignis.app import IgnisApp
from ignis.utils import get_n_monitors
from ignis.widgets import Widget
from os import path

from widgets import battery, clock, volume, wlan, windows, workspaces

app = IgnisApp.get_default()
app.apply_css(path.expanduser("~/.config/ignis/style.scss"))


def bottom_bar(monitor):
    return Widget.Window(
        anchor=["left", "bottom", "right"],
        child=Widget.CenterBox(start_widget=Widget.Box(child=[windows()])),
        css_classes=["bar"],
        exclusivity="exclusive",
        layer="top",
        monitor=monitor,
        namespace="bottom-bar-{monitor}".format(monitor=monitor),
    )


def top_bar(monitor):
    return Widget.Window(
        anchor=["left", "top", "right"],
        child=Widget.CenterBox(
            start_widget=Widget.Box(child=[workspaces()]),
            center_widget=Widget.Box(child=[clock()]),
            end_widget=Widget.Box(spacing=6, child=[wlan(), volume(), battery()]),
        ),
        css_classes=["bar"],
        exclusivity="exclusive",
        layer="top",
        monitor=monitor,
        namespace="top-bar-{monitor}".format(monitor=monitor),
    )


for monitor in range(get_n_monitors()):
    bottom_bar(monitor)
    top_bar(monitor)
