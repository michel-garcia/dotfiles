from libqtile.config import DropDown, Group, ScratchPad
from libqtile.utils import guess_terminal


terminal = guess_terminal() or "kitty"

def init_groups():
    match(terminal):
        case "kitty":
            cmd = "kitty --override background_opacity=.9"
        case _:
            cmd = terminal
    dropdown = DropDown(
        "term",
        cmd,
        height=.95,
        on_focus_lost_hide=True,
        opacity=1,
        width=.95,
        x=.025,
        y=.025,
    )
    groups = list(map(lambda i: Group(str(i)), range(1, 10)))
    groups.append(ScratchPad("scratchpad", [dropdown]))
    return groups
