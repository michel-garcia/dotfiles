from ignis.services.network import NetworkService
from ignis.services.network.wifi import Wifi
from ignis.utils import Poll
from ignis.widgets import Widget

service = NetworkService.get_default()


def wlan():
    def update(icon, label):
        icon.set_image(service.wifi.icon_name)
        device = next(iter(service.wifi.devices))
        if not device:
            return
        access_point = next(iter(device.access_points))
        if not access_point:
            return
        text = "{strength}%".format(strength=access_point.strength)
        label.set_text(text)

    icon = Widget.Icon(pixel_size=16)
    label = Widget.Label()
    Poll(3000, lambda _: update(icon, label))
    return Widget.Box(spacing=6, child=[icon, label])
