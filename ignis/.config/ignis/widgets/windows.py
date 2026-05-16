from ignis.services.hyprland import HyprlandService
from ignis.widgets import Widget

hyprland = HyprlandService.get_default()


class Window(Widget.Button):
    def __init__(self, window):
        self.window = window
        super().__init__(
            child=Widget.Label(
                ellipsize="end",
                label="[ {name} ]".format(name=window.class_name),
                max_width_chars=32,
            ),
            css_classes=["window"],
            on_click=lambda _: self.focus(),
        )
        if window.pid == hyprland.active_window.pid:
            self.add_css_class("active")

    def focus(self):
        command = 'dispatch hl.dsp.focus({{ window = "address:{address}" }})'.format(
            address=self.window.address
        )
        hyprland.send_command(command)


class Windows(Widget.Box):
    def __init__(self, monitor):
        super().__init__(spacing=4)
        self.update(monitor)
        for signal in ("notify::active-window", "notify::active-workspace"):
            hyprland.connect(signal, lambda *_: self.update(monitor))

    def update(self, monitor):
        if not hyprland.active_workspace:
            self.child = []
            return
        windows = [
            w
            for w in hyprland.windows
            if w.workspace_id == hyprland.active_workspace.id
        ]
        self.child = [Window(w) for w in windows]
