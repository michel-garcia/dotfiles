from ignis.services.audio import AudioService
from ignis.utils import Poll
from ignis.widgets import Widget


class Volume(Widget.Box):
    def __init__(self):
        audio = AudioService.get_default()
        super().__init__(
            child=[
                Widget.Icon(image=audio.speaker.bind("icon_name"), pixel_size=16),
                Widget.Label(
                    label=audio.speaker.bind(
                        "volume",
                        transform=lambda volume: "{volume}%".format(volume=volume),
                    )
                ),
            ],
            spacing=6,
        )
