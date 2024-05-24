from libqtile import hook

from subprocess import Popen

from layouts import layouts, floating_layout
from groups import groups
from keys import keys, wl_input_rules
from mouse import mouse
from screens import screens

widget_defaults = dict(
    font="Ubuntu",
    fontsize=14,
    padding=3,
)

auto_fullscreen = True
auto_minimize = False
bring_front_click = False
cursor_warp = False
dgroups_app_rules = []
dgroups_key_binder = None
extension_defaults = widget_defaults.copy()
floats_kept_above = True
focus_on_window_activation = "smart"
follow_mouse_focus = True
reconfigure_screens = True
wmname = "LG3D"

@hook.subscribe.startup_once
def autostart():
    Popen(["waypaper", "--restore"])
