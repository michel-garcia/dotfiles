import psutil

from .icontext import ThreadIconText


class CPU(ThreadIconText):
    defaults = [
        ("icon_name", "indicator-sensors-cpu"),
        ("update_interval", 1.0),
    ]

    def __init__(self, **config):
        super().__init__(**config)
        self.add_defaults(self.defaults)

    def poll(self):
        load_percent = round(psutil.cpu_percent(), 1)
        text = "{load_percent}%".format(load_percent=load_percent)
        return self.icon_name, text
