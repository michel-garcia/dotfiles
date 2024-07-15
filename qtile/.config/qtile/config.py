from libqtile import hook, qtile

from groups import init_groups
from input import init_keys, init_mouse, init_input_rules
from layouts import init_layouts, init_floating_layout
from screens import init_screens
from utils import launch
from widgets import init_widget_defaults


auto_fullscreen = True
auto_minimize = False
bring_front_click = False
cursor_warp = False
dgroups_app_rules = []
dgroups_key_binder = None
extension_defaults = init_widget_defaults()
floating_layout = init_floating_layout()
floats_kept_above = True
focus_on_window_activation = "smart"
follow_mouse_focus = True
groups = init_groups()
keys = init_keys(groups)
layouts = init_layouts()
mouse = init_mouse()
reconfigure_screens = True
screens = init_screens()
wmname = "LG3D"
wl_input_rules = init_input_rules()

@hook.subscribe.startup_once
def startup_once():
    launch("waypaper --restore")

@hook.subscribe.client_urgent_hint_changed
def client_urgent_hint_changed(client):
    qtile.current_screen.set_group(client.group)
    client.group.focus(client)
