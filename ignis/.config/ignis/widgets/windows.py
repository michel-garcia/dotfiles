from ignis.services.hyprland import HyprlandService
from ignis.widgets import Widget
import textwrap

service = HyprlandService.get_default()


def window(w):
    widget = Widget.Button(
        child=Widget.Label(
            label=textwrap.shorten(w.title, placeholder="...", width=32)
        ),
        css_classes=["window"],
        on_click=lambda _: service.send_command(
            "dispatch focuswindow address:{address}".format(address=w.address)
        ),
    )
    if w.pid == service.active_window.pid:
        widget.add_css_class("active")
    return widget


def windows():
    return Widget.EventBox(
        spacing=4,
        child=service.bind_many(
            ["active_workspace", "windows", "active_window"],
            transform=lambda active_workspace, windows, _: [
                window(w) for w in windows if w.workspace_id == active_workspace.id
            ],
        ),
    )
