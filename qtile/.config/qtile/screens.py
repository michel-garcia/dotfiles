from libqtile import bar
from libqtile.config import Screen

from utils import get_screen_count
from widgets import init_widgets


def init_screens():
    screen_count = get_screen_count()
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
        for _ in range(screen_count)
    ]
