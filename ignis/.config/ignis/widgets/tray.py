import asyncio
from ignis.services.system_tray import SystemTrayService, SystemTrayItem
from ignis.widgets import Widget

service = SystemTrayService.get_default()


def tray_item(item):
    menu = item.menu.copy() if item.menu else None
    if menu:
        menu.add_css_class("tray-menu")
    widget = Widget.Button(
        child=Widget.Box(child=[Widget.Icon(image=item.bind("icon")), menu]),
        on_click=lambda _: asyncio.create_task(item.active_async()),
        on_right_click=lambda _: menu.popup() if menu else None,
        tooltip_text=item.bind("tooltip"),
    )
    item.connect("removed", lambda _: widget.unparent())
    return widget


def tray():
    widget = Widget.Box(css_classes=["tray"], spacing=4)
    service.connect("added", lambda _, item: widget.append(tray_item(item)))
    return widget
