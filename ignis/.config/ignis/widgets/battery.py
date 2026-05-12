from ignis.services.upower import UPowerService
from ignis.utils import Poll
from ignis.widgets import Widget

upower = UPowerService.get_default()


class Battery(Widget.Box):
    def __init__(self):
        self.label = Widget.Label()
        super().__init__(
            child=[self.label],
            spacing=6,
            visible=False,
        )
        Poll(3000, lambda _: self.update())

    def update(self):
        try:
            battery = upower.batteries[0]
            text = "BAT: {percent}%".format(percent=int(battery.percent))
            self.label.set_text(text)
            self.set_visible(True)
        except:
            pass
