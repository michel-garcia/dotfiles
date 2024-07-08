from libqtile.config import DropDown, Group, ScratchPad
from libqtile.utils import guess_terminal

terminal = guess_terminal() or "kitty"
match(terminal):
    case "kitty":
        cmd = "kitty --override background_opacity=.9"
    case _:
        cmd = terminal

groups = [
    *[Group(i) for i in "123456789"],
    ScratchPad("scratchpad", [
        DropDown(
            "term",
            cmd,
            height=.95,
            on_focus_lost_hide=True,
            opacity=1,
            width=.95,
            x=.025,
            y=.025,
        )
    ])
]
