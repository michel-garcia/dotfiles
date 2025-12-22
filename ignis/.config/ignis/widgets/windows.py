from ignis.services.niri import NiriService
from ignis.widgets import Widget
from ignis.utils import get_monitor

niri = NiriService.get_default()


class Window(Widget.Button):
    def __init__(self, window):
        label = "[ {app_id} ]".format(app_id=window.app_id)
        super().__init__(
            child=Widget.Label(ellipsize="end", label=label, max_width_chars=32),
            css_classes=["window"],
            on_click=lambda _: window.focus(),
        )
        if window.id == niri.active_window.id:
            self.add_css_class("active")


class Windows(Widget.Box):
    def __init__(self, monitor):
        super().__init__(spacing=4)
        self.sync(monitor)
        niri.connect("notify::windows", lambda *_: self.sync(monitor))
        niri.connect("notify::active-window", lambda *_: self.sync(monitor))
        niri.connect("notify::workspaces", lambda *_: self.sync(monitor))

    def sync(self, monitor):
        monitor_name = get_monitor(monitor).get_connector()
        workspace = next(
            (w for w in niri.workspaces if w.output == monitor_name and w.is_active),
            None,
        )
        if not workspace:
            self.child = []
            return
        windows = [w for w in niri.windows if w.workspace_id == workspace.id]
        self.child = [Window(w) for w in windows]
