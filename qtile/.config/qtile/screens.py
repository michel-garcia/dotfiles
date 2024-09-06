from libqtile import bar
from libqtile.config import Screen

from widgets import init_widgets


def init_screens():
    return [
        Screen(
            bottom=bar.Gap(4),
            left=bar.Gap(4),
            right=bar.Gap(4),
            top=bar.Bar(
                init_widgets(),
                background="#000",
                margin=[0, 0, 4, 0],
                size=32,
            ),
        )
        for _ in range(3)
    ]
