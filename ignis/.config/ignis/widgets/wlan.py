from ignis.services.network import NetworkService
from ignis.services.network.wifi import Wifi
from ignis.utils import Poll
from ignis.widgets import Widget

network = NetworkService.get_default()


class Wlan(Widget.Box):
    def __init__(self):
        self.icon = Widget.Icon(pixel_size=16)
        self.label = Widget.Label()
        super().__init__(
            child=[self.icon, self.label],
            spacing=6,
            visible=False,
        )
        Poll(3000, lambda _: self.update())

    def update(self):
        device = next(iter(network.wifi.devices))
        if not device:
            return
        access_point = next(iter(device.access_points))
        if not access_point:
            return
        self.icon.set_image(network.wifi.icon_name)
        text = "{strength}%".format(strength=access_point.strength)
        self.label.set_text(text)
        self.set_visible(True)
