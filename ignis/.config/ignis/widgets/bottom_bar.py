from ignis.widgets import Widget

from .cpu import Cpu
from .memory import Memory
from .windows import Windows


class BottomBar(Widget.Window):
    def __init__(self, monitor):
        super().__init__(
            anchor=["left", "bottom", "right"],
            child=Widget.CenterBox(
                start_widget=Widget.Box(child=[Windows(monitor)]),
                end_widget=Widget.Box(child=[Cpu(), Memory()], spacing=6),
            ),
            css_classes=["bar"],
            exclusivity="exclusive",
            layer="top",
            monitor=monitor,
            namespace="bottom-bar:{monitor}".format(monitor=monitor),
        )
