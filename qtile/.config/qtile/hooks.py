from libqtile import hook, qtile

from utils import launch


def startup_once():
    launch("waypaper --restore")
    launch("nitrogen --restore")


def client_urgent_hint_changed(client):
    qtile.current_screen.set_group(client.group)
    client.group.focus(client)


def init_hooks():
    hook.subscribe.startup_once(startup_once)
    hook.subscribe.client_urgent_hint_changed(client_urgent_hint_changed)
