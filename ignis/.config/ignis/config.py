from ignis.app import IgnisApp
from ignis.utils import get_n_monitors
from os import path

from widgets import BottomBar, TopBar

app = IgnisApp.get_default()
app.apply_css(path.expanduser("~/.config/ignis/style.scss"))

for monitor in range(get_n_monitors()):
    BottomBar(monitor)
    TopBar(monitor)
