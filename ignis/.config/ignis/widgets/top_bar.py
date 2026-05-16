from ignis.widgets import Widget

from .battery import Battery
from .clock import Clock
from .tray import Tray
from .volume import Volume
from .wlan import Wlan
from .workspaces import Workspaces


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
