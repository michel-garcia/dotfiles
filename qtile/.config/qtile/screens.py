from libqtile import bar
from libqtile.config import Screen

from widgets import init_bottom_widgets, init_top_widgets


def init_screens():
    return [
        Screen(
            bottom=bar.Bar(
                init_bottom_widgets(),
                background="#202020",
                margin=[4, 0, 0, 0],
                size=32,
            ),
            left=bar.Gap(4),
            right=bar.Gap(4),
            top=bar.Bar(
                init_top_widgets(),
                background="#202020",
                margin=[0, 0, 4, 0],
                size=32,
            ),
        )
        for _ in range(3)
    ]
