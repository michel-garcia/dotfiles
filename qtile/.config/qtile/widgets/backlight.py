import os

from .icontext import ThreadIconText


BACKLIGHT_DIR = "/sys/class/backlight"


class Backlight(ThreadIconText):
    defaults = [
        ("backlight_name", None),
        ("high_icon_name", "brightness-high-symbolic"),
        ("low_icon_name", "brightness-low-symbolic"),
        ("medium_icon_name", "brightness-medium-symbolic"),
        ("update_interval", 0.2),
    ]

    def __init__(self, **config):
        super().__init__(**config)
        self.add_defaults(self.defaults)

    def _configure(self, qtile, bar):
        super()._configure(qtile, bar)
        if not self.backlight_name and os.path.isdir(BACKLIGHT_DIR):
            backlights = os.listdir(BACKLIGHT_DIR)
            if backlights:
                self.backlight_name = backlights.pop(0)

    def poll(self):
        path = os.path.join(BACKLIGHT_DIR, self.backlight_name, "brightness")
        with open(path) as file:
            brightness = file.read().strip()
        path = os.path.join(BACKLIGHT_DIR, self.backlight_name, "max_brightness")
        with open(path) as file:
            max_brightness = file.read().strip()
        percent = float(brightness) / float(max_brightness) * 100
        if percent > 70:
            icon = self.high_icon_name
        elif percent > 30:
            icon = self.medium_icon_name
        else:
            icon = self.low_icon_name
        text = "{percent:.0f}%".format(percent=percent)
        return icon, text
