from ignis.services.hyprland import HyprlandService
from ignis.widgets import Widget

service = HyprlandService.get_default()


def workspace(w):
    widget = Widget.Button(
        css_classes=["workspace"],
        on_click=lambda _: w.switch_to(),
        child=Widget.Label(label=str(w.id)),
    )
    if w.id == service.active_workspace.id:
        widget.add_css_class("active")

    return widget


def workspaces():
    return Widget.EventBox(
        spacing=4,
        child=service.bind_many(
            ["workspaces", "active_workspace"],
            transform=lambda workspaces, _: [workspace(i) for i in workspaces],
        ),
    )
