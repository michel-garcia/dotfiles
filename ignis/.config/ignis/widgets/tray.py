import asyncio
from ignis.services.system_tray import SystemTrayService, SystemTrayItem
from ignis.widgets import Widget


class TrayItem(Widget.Button):
    def __init__(self, item):
        menu = item.menu.copy() if item.menu else None
        if menu:
            menu.add_css_class("tray-menu")
        super().__init__(
            child=Widget.Box(child=[Widget.Icon(image=item.bind("icon")), menu]),
            on_click=lambda _: asyncio.create_task(item.active_async()),
            on_right_click=lambda _: menu.popup() if menu else None,
            tooltip_text=item.bind("tooltip"),
        )


class Tray(Widget.Box):
    def __init__(self):
        super().__init__(
            css_classes=["tray"],
            spacing=4,
        )
        systray = SystemTrayService.get_default()
        systray.connect("added", lambda _, item: self.append(TrayItem(item)))
