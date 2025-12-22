from ignis.services.niri import NiriService
from ignis.widgets import Widget
from ignis.utils import get_monitor

niri = NiriService.get_default()


class Workspace(Widget.Button):
    def __init__(self, workspace):
        super().__init__(
            child=Widget.Label(label=str(workspace.idx)),
            css_classes=["workspace"],
            on_click=lambda _: workspace.switch_to(),
        )
        if workspace.is_active:
            self.add_css_class("active")
            return
        windows = [w for w in niri.windows if w.workspace_id == workspace.id]
        if len(windows) == 0:
            self.add_css_class("empty")


class Workspaces(Widget.Box):
    def __init__(self, monitor):
        super().__init__(spacing=4)
        self.sync(monitor)
        niri.connect("notify::workspaces", lambda *_: self.sync(monitor))

    def sync(self, monitor):
        monitor_name = get_monitor(monitor).get_connector()
        workspaces = [w for w in niri.workspaces if w.output == monitor_name]
        self.child = [Workspace(w) for w in workspaces]
