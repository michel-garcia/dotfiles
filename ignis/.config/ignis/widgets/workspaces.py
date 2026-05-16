from ignis.services.hyprland import HyprlandService
from ignis.widgets import Widget
from ignis.utils import get_monitor

hyprland = HyprlandService.get_default()


class Workspace(Widget.Button):
    def __init__(self, workspace):
        self.workspace = workspace
        super().__init__(
            child=Widget.Label(label=workspace.name),
            css_classes=["workspace"],
            on_click=lambda _: self.switch_to(),
        )
        if workspace.id == hyprland.active_workspace.id:
            self.add_css_class("active")
            return
        windows = [w for w in hyprland.windows if w.workspace_id == workspace.id]
        if len(windows) == 0:
            self.add_css_class("empty")

    def switch_to(self):
        command = "dispatch hl.dsp.focus({{ workspace = {id} }})".format(
            id=self.workspace.id
        )
        hyprland.send_command(command)


class Workspaces(Widget.Box):
    def __init__(self, monitor):
        super().__init__(spacing=4)
        self.update(monitor)
        hyprland.connect("notify::active-workspace", lambda *_: self.update(monitor))

    def update(self, monitor):
        monitor_name = get_monitor(monitor).get_connector()
        workspaces = [w for w in hyprland.workspaces if w.monitor == monitor_name]
        self.child = [Workspace(w) for w in workspaces]
