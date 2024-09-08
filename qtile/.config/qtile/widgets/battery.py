import os

from .icontext import ThreadIconText


BATTERY_DIR = "/sys/class/power_supply"


class Battery(ThreadIconText):
    defaults = [
        ("battery_name", None),
        ("empty_charging_icon_name", "battery-empty-charging"),
        ("empty_icon_name", "battery-empty"),
        ("full_charging_icon_name", "battery-full-charging"),
        ("full_icon_name", "battery-full"),
        ("good_charging_icon_name", "battery-good-charging"),
        ("good_icon_name", "battery-good"),
        ("low_charging_icon_name", "battery-low-charging"),
        ("low_icon_name", "battery-low"),
        ("unknown_icon_name", "battery-missing"),
        ("update_interval", 2),
    ]

    def __init__(self, **config):
        super().__init__(**config)
        self.add_defaults(self.defaults)

    def _configure(self, qtile, bar):
        super()._configure(qtile, bar)
        if not self.battery_name and os.path.isdir(BATTERY_DIR):
            batteries = [
                name for name in os.listdir(BATTERY_DIR) if name.startswith("BAT")
            ]
            self.battery_name = batteries.pop(0)

    def poll(self):
        path = os.path.join(BATTERY_DIR, self.battery_name, "status")
        with open(path) as file:
            status = file.read().strip()
        path = os.path.join(BATTERY_DIR, self.battery_name, "capacity")
        with open(path) as file:
            capacity = file.read().strip()
        percent = int(capacity)
        match status.upper():
            case "CHARGING":
                if percent > 90:
                    icon = self.full_charging_icon_name
                elif percent > 40:
                    icon = self.good_charging_icon_name
                elif percent >= 20:
                    icon = self.low_charging_icon_name
                else:
                    icon = self.empty_charging_icon_name
            case "DISCHARGING":
                if percent > 90:
                    icon = self.full_icon_name
                elif percent > 40:
                    icon - self.good_icon_name
                elif percent >= 20:
                    icon = self.low_icon_name
                else:
                    icon = self.empty_icon_name
            case "EMPTY":
                icon = self.empty_icon_name
            case "FULL":
                icon = self.full_icon_name
            case _:
                icon = self.unknown_icon_name
        text = "{percent}%".format(percent=percent)
        return icon, text
