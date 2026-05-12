from ignis.services.audio import AudioService
from ignis.utils import Poll
from ignis.widgets import Widget


class Volume(Widget.Box):
    def __init__(self):
        audio = AudioService.get_default()
        super().__init__(
            child=[
                Widget.Label(
                    label=audio.speaker.bind(
                        "volume",
                        transform=lambda volume: "VOL: {volume}%".format(volume=volume),
                    )
                ),
            ],
            spacing=6,
        )
