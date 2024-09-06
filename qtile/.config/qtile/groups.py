from libqtile.config import Group


def init_groups():
    return [Group(str(i)) for i in range(1, 10)]
