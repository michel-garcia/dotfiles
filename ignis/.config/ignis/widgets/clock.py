from datetime import datetime
from ignis.utils import Poll
from ignis.widgets import Widget


def clock(format="%a %b %d %H:%M:%S"):
    def update(label):
        text = datetime.now().strftime(format)
        label.set_text(text)

    label = Widget.Label()
    Poll(1000, lambda _: update(label))
    return label
