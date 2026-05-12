from ignis.services.network import NetworkService
from ignis.services.network.wifi import Wifi
from ignis.utils import Poll
from ignis.widgets import Widget

network = NetworkService.get_default()


class Wlan(Widget.Box):
    def __init__(self):
        self.label = Widget.Label()
        super().__init__(
            child=[self.label],
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
        text = "WIFI: {strength}%".format(strength=access_point.strength)
        self.label.set_text(text)
        self.set_visible(True)
