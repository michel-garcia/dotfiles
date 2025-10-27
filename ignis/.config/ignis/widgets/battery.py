from ignis.services.upower import UPowerService
from ignis.utils import Poll
from ignis.widgets import Widget


class Battery(Widget.Box):
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
        try:
            upower = UPowerService.get_default()
            battery = upower.batteries[0]
            self.icon.set_image(battery.icon_name)
            text = "{percent}%".format(percent=int(battery.percent))
            self.label.set_text(text)
            self.set_visible(True)
        except:
            pass
