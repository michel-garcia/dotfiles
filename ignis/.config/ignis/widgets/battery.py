from ignis.services.upower import UPowerService
from ignis.utils import Poll
from ignis.widgets import Widget

service = UPowerService.get_default()


def battery():
    def update(icon, label):
        battery = service.batteries[0]
        icon.set_image(battery.icon_name)
        text = "{percent}%".format(percent=int(battery.percent))
        label.set_text(text)

    icon = Widget.Icon(pixel_size=16)
    label = Widget.Label()
    Poll(3000, lambda _: update(icon, label))
    return Widget.Box(spacing=6, child=[icon, label])
