from ignis.services.hyprland import HyprlandService
from ignis.widgets import Widget


class Window(Widget.Button):
    def __init__(self, window):
        hyprland = HyprlandService.get_default()
        super().__init__(
            child=Widget.Label(ellipsize="end", label=window.title, max_width_chars=32),
            css_classes=["window"],
            on_click=lambda _: hyprland.send_command(
                "dispatch focuswindow address:{address}".format(address=window.address)
            ),
        )
        if window.pid == hyprland.active_window.pid:
            self.add_css_class("active")


class Windows(Widget.EventBox):
    def __init__(self, monitor):
        hyprland = HyprlandService.get_default()
        super().__init__(
            child=hyprland.bind_many(
                ["active_workspace", "windows", "active_window"],
                transform=lambda active_workspace, windows, _: [
                    Window(window)
                    for window in windows
                    if window.workspace_id
                    == hyprland.monitors[monitor].active_workspace_id
                ],
            ),
            spacing=4,
        )
