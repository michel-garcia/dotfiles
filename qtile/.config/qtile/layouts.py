from libqtile.config import Match
from libqtile.layout.columns import Columns
from libqtile.layout.floating import Floating

from colors import colors

layouts = [
    Columns(
        border_normal="#000",
        border_focus=colors["primary"],
        border_on_single=True,
        border_width=2,
        margin=4
    ),
]

floating_layout = Floating(
    border_focus=colors["primary"],
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
