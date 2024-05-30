from subprocess import Popen

from libqtile import hook, qtile


@hook.subscribe.startup_once
def startup_once():
    run("waypaper --restore")


@hook.subscribe.client_urgent_hint_changed
def client_urgent_hint_changed(client):
    qtile.current_screen.set_group(client.group)
    client.group.focus(client)


def run(cmd):
    Popen(cmd, shell=True)
