from ignis.services.hyprland import HyprlandService
from ignis.widgets import Widget


class Workspace(Widget.Button):
    def __init__(self, workspace):
        name = str(workspace.id - workspace.monitor_id * 10)
        super().__init__(
            child=Widget.Label(label=name),
            css_classes=["workspace"],
            on_click=lambda _: workspace.switch_to(),
        )
        hyprland = HyprlandService.get_default()
        if workspace.id == hyprland.active_workspace.id:
            self.add_css_class("active")
        elif workspace.windows == 0:
            self.add_css_class("empty")


class Workspaces(Widget.EventBox):
    def __init__(self, monitor):
        hyprland = HyprlandService.get_default()
        super().__init__(
            child=hyprland.bind_many(
                ["workspaces", "active_workspace"],
                transform=lambda workspaces, _: [
                    Workspace(workspace)
                    for workspace in workspaces
                    if workspace.monitor_id == monitor
                ],
            ),
            spacing=4,
        )
