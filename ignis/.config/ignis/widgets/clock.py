from datetime import datetime
from ignis.utils import Poll
from ignis.widgets import Widget


class Clock(Widget.Label):
    def __init__(self, format="%a %b %d %H:%M:%S"):
        self.format = format
        super().__init__()
        Poll(1000, lambda _: self.update())

    def update(self):
        text = datetime.now().strftime(self.format)
        self.set_text(text)
