from libqtile.config import Match
from libqtile.layout.columns import Columns
from libqtile.layout.floating import Floating


def init_layouts():
    return [
        Columns(
            border_normal="#000",
            border_focus="#fabd2f",
            border_on_single=True,
            border_width=2,
            margin=4
        ),
    ]

def init_floating_layout():
    return Floating(
        border_focus="#fabd2f",
        float_rules=[
            *Floating.default_float_rules,
            Match(wm_class="confirmreset"),
            Match(wm_class="makebranch"),
            Match(wm_class="maketag"),
            Match(wm_class="ssh-askpass"),
            Match(title="branchdialog"),
            Match(title="pinentry"),
        ]
    )
