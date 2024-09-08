import re
import subprocess

from .icontext import ThreadIconText


class PulseVolume(ThreadIconText):
    defaults = [
        ("high_icon_name", "audio-volume-high"),
        ("low_icon_name", "audio-volume-low"),
        ("medium_icon_name", "audio-volume-medium"),
        ("muted_icon_name", "audio-volume-muted"),
        ("update_interval", 0.2),
    ]

    def __init__(self, **config):
        super().__init__(**config)
        self.add_defaults(self.defaults)

    def poll(self):
        output = (
            subprocess.check_output("pactl get-sink-mute @DEFAULT_SINK@", shell=True)
            .decode()
            .strip()
        )
        muted = output.upper().endswith("YES")
        output = (
            subprocess.check_output("pactl get-sink-volume @DEFAULT_SINK@", shell=True)
            .decode()
            .strip()
        )
        matches = re.findall(r"(\d+)%", output)
        volume = int(matches.pop(0))
        if muted:
            icon = self.muted_icon_name
        else:
            if volume > 70:
                icon = self.high_icon_name
            elif volume > 30:
                icon = self.medium_icon_name
            else:
                icon = self.low_icon_name
        text = "{volume}%".format(volume=volume)
        return icon, text
