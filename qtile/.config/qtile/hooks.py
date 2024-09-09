from subprocess import Popen

from libqtile import hook, qtile


def launch(cmd):
    Popen(cmd, shell=True)


def startup_once():
    launch("waypaper --restore")


def client_urgent_hint_changed(client):
    screen = qtile.find_closest_screen(client.x, client.y)
    if screen:
        screen.set_group(client.group)


def init_hooks():
    hook.subscribe.startup_once(startup_once)
    hook.subscribe.client_urgent_hint_changed(client_urgent_hint_changed)
