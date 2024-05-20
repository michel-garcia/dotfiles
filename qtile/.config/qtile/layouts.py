from libqtile import layout
from libqtile.config import Match

from colors import colors

layouts = [
    layout.Columns(
        border_normal="#000",
        border_focus=colors["primary"],
        border_on_single=True,
        border_width=2,
        margin=4
    ),
]

floating_layout = layout.Floating(
    border_focus=colors["primary"],
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ]
)
