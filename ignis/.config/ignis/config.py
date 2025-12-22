from ignis.app import IgnisApp
from ignis.widgets import Widget
from ignis.utils import get_n_monitors
from os import path

from widgets import Battery, Clock, Memory, Tray, Volume, Wlan, Windows, Workspaces


class BottomBar(Widget.Window):
    def __init__(self, monitor):
        super().__init__(
            anchor=["left", "bottom", "right"],
            child=Widget.CenterBox(
                start_widget=Widget.Box(child=[Windows(monitor)]),
                end_widget=Widget.Box(child=[Memory()]),
            ),
            css_classes=["bar"],
            exclusivity="exclusive",
            layer="top",
            monitor=monitor,
            namespace="bottom-bar:{monitor}".format(monitor=monitor),
        )


class TopBar(Widget.Window):
    def __init__(self, monitor):
        super().__init__(
            anchor=["left", "top", "right"],
            child=Widget.CenterBox(
                start_widget=Widget.Box(child=[Workspaces(monitor)]),
                center_widget=Widget.Box(child=[Clock()]),
                end_widget=Widget.Box(
                    child=[Tray(), Wlan(), Volume(), Battery()],
                    spacing=6,
                ),
            ),
            css_classes=["bar"],
            exclusivity="exclusive",
            layer="top",
            monitor=monitor,
            namespace="top-bar:{monitor}".format(monitor=monitor),
        )


app = IgnisApp.get_default()
app.apply_css(path.expanduser("~/.config/ignis/style.scss"))

for monitor in range(get_n_monitors()):
    BottomBar(monitor)
    TopBar(monitor)
