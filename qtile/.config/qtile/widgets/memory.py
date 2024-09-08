import psutil

from .icontext import ThreadIconText


class Memory(ThreadIconText):
    defaults = [
        ("icon_name", "indicator-sensors-memory"),
        ("update_interval", 1.0),
    ]

    def __init__(self, **config):
        super().__init__(**config)
        self.add_defaults(self.defaults)

    def poll(self):
        memory = psutil.virtual_memory()
        factor = pow(1024, 3)
        text = "{used:.1f}G/{total:.1f}G".format(
            used=memory.used / factor, total=memory.total / factor
        )
        return self.icon_name, text
