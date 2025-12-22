import psutil
from ignis.utils import Poll
from ignis.widgets import Widget


class Cpu(Widget.Box):
    def __init__(self):
        self.label = Widget.Label()
        super().__init__(
            child=[self.label],
            spacing=6,
        )
        Poll(1000, lambda _: self.update())

    def update(self):
        load_percent = psutil.cpu_percent()
        text = "CPU: {load_percent:.1f}%".format(load_percent=load_percent)
        self.label.set_text(text)
