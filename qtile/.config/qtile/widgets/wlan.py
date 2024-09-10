import iwlib

from .icontext import ThreadIconText


class Wlan(ThreadIconText):
    defaults = [
        ("excellent_signal_icon_name", "network-wireless-signal-excellent"),
        ("good_signal_icon_name", "network-wireless-signal-good"),
        ("low_signal_icon_name", "network-wireless-signal-low"),
        ("interface_name", "wlan0"),
        ("none_signal_icon_name", "network-wireless-signal-none"),
        ("ok_signal_icon_name", "network-wireless-signal-ok"),
        ("update_interval", 1.0),
    ]

    def __init__(self, **config):
        super().__init__(**config)
        self.add_defaults(self.defaults)

    def poll(self):
        interface = iwlib.get_iwconfig(self.interface_name)
        if not interface.get("ESSID"):
            return
        stats = interface.get("stats")
        if not stats:
            return
        quality = stats.get("quality")
        percent = int(quality)
        if percent >= 80:
            icon = self.excellent_signal_icon_name
        elif percent >= 60:
            icon = self.good_signal_icon_name
        elif percent >= 40:
            icon = self.ok_signal_icon_name
        elif percent >= 20:
            icon = self.low_signal_icon_name
        else:
            icon = self.none_signal_icon_name
        text = "{percent}%".format(percent=percent)
        return icon, text
