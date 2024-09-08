import psutil

from .icontext import ThreadIconText


class DiskUsage(ThreadIconText):
    defaults = [
        ("icon_name", "indicator-sensors-disk"),
        ("partition", "/"),
        ("update_interval", 60.0),
    ]

    def __init__(self, **config):
        super().__init__(**config)
        self.add_defaults(self.defaults)

    def poll(self):
        usage = psutil.disk_usage(self.partition)
        factor = pow(1024, 3)
        text = "{used:.0f}G/{total:.0f}G".format(
            used=usage.used / factor, total=usage.total / factor
        )
        return self.icon_name, text
