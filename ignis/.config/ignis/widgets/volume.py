from ignis.services.audio import AudioService
from ignis.utils import Poll
from ignis.widgets import Widget

service = AudioService.get_default()


def volume():
    def update(icon, label):
        icon.set_image(service.speaker.icon_name)
        text = "{volume}%".format(volume=service.speaker.volume)
        label.set_text(text)
        if parent := label.get_parent():
            parent.set_visible(True)

    icon = Widget.Icon(pixel_size=16)
    label = Widget.Label()
    Poll(3000, lambda _: update(icon, label))
    return Widget.Box(spacing=6, child=[icon, label], visible=False)
