from libqtile import hook, qtile

from utils import launch


def startup_once():
    if qtile.core.name == "x11":
        launch("nitrogen --restore")
    elif qtile.core.name == "wayland":
        launch("waypaper --restore")


def client_urgent_hint_changed(client):
    screen = qtile.find_closest_screen(client.x, client.y)
    if screen:
        screen.set_group(client.group)


def init_hooks():
    hook.subscribe.startup_once(startup_once)
    hook.subscribe.client_urgent_hint_changed(client_urgent_hint_changed)
