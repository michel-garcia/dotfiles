from ignis.services.hyprland import HyprlandService
from ignis.widgets import Widget

hyprland = HyprlandService.get_default()


def workspace(w):
    widget = Widget.Button(
        css_classes=["workspace"],
        on_click=lambda _: w.switch_to(),
        child=Widget.Label(label=str(w.id)),
    )
    if w.id == hyprland.active_workspace.id:
        widget.add_css_class("active")

    return widget


def workspaces():
    return Widget.EventBox(
        spacing=4,
        child=hyprland.bind_many(
            ["workspaces", "active_workspace"],
            transform=lambda workspaces, active_workspace: [
                workspace(i) for i in workspaces
            ],
        ),
    )
