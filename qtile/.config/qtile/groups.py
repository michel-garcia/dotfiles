from libqtile.config import Group


def init_groups():
    return [Group(str(i), label="󰄯") for i in range(1, 10)]
