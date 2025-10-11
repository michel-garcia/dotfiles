from ignis.app import IgnisApp
from ignis.utils import get_n_monitors
from ignis.widgets import Widget
from os import path

from widgets import battery, clock, volume, wlan, workspaces

app = IgnisApp.get_default()
app.apply_css(path.expanduser("~/.config/ignis/style.scss"))


def bar(monitor):
    return Widget.Window(
        css_classes=["bar"],
        namespace="bar-{monitor}".format(monitor=monitor),
        monitor=monitor,
        anchor=["left", "top", "right"],
        exclusivity="exclusive",
        layer="top",
        child=Widget.CenterBox(
            start_widget=Widget.Box(child=[workspaces()]),
            center_widget=Widget.Box(child=[clock()]),
            end_widget=Widget.Box(spacing=6, child=[wlan(), volume(), battery()]),
        ),
    )


for monitor in range(get_n_monitors()):
    bar(monitor)
