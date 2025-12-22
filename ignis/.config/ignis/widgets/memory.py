import psutil
from ignis.utils import Poll
from ignis.widgets import Widget


class Memory(Widget.Box):
    def __init__(self):
        self.label = Widget.Label()
        super().__init__(
            child=[self.label],
            spacing=6,
        )
        Poll(1000, lambda _: self.update())

    def update(self):
        memory = psutil.virtual_memory()
        factor = pow(1024, 3)
        text = "RAM: {used:.1f}/{total:.1f}G".format(
            used=memory.used / factor, total=memory.total / factor
        )
        self.label.set_text(text)
