from libqtile import qtile
from libqtile.backend.wayland.inputs import InputConfig
from libqtile.config import Click, Drag, Key
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal


mod = "mod4"
terminal = guess_terminal()

def init_keys(groups):
    keys = [
        Key([mod], "h", lazy.layout.left()),
        Key([mod], "l", lazy.layout.right()),
        Key([mod], "j", lazy.layout.down()),
        Key([mod], "k", lazy.layout.up()),
        Key([mod], "Tab", lazy.group.next_window()),
        Key([mod, "shift"], "Tab", lazy.group.prev_window()),
        Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
        Key([mod, "control"], "h", lazy.layout.grow_left()),
        Key([mod, "control"], "l", lazy.layout.grow_right()),
        Key([mod, "control"], "j", lazy.layout.grow_down()),
        Key([mod, "control"], "k", lazy.layout.grow_up()),
        Key([mod], "n", lazy.layout.normalize()),
        Key([mod], "Return", lazy.spawn(terminal)),
        Key([mod, "shift"], "s", lazy.group["scratchpad"].dropdown_toggle("term")),
        Key([mod], "w", lazy.window.kill()),
        Key([mod], "f", lazy.window.toggle_fullscreen()),
        Key([mod], "t", lazy.window.toggle_floating()),
        Key([mod, "control"], "r", lazy.reload_config()),
        Key([mod, "control"], "q", lazy.shutdown()),
        Key([mod], "r", lazy.spawn("rofi -show drun")),
    ]
    for vt in range(1, 8):
        keys.append(
            Key(
                ["control", "mod1"],
                f"f{vt}",
                lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            )
        )
    for i in groups:
        keys.extend([
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
            ),
        ])
    return keys

def init_mouse():
    return [
        Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
        Click([mod], "Button2", lazy.window.bring_to_front()),
    ]

def init_input_rules():
    return {
        "type:keyboard": InputConfig(
            kb_layout="us",
            kb_variant="altgr-intl"
        )
    }
