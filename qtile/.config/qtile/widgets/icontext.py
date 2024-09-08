from cairosvg import svg2png
from configparser import ConfigParser
import os
from xdg import IconTheme, Mime

from libqtile.bar import CALCULATED
from libqtile.images import Img
from libqtile.log_utils import logger
from libqtile.widget.base import _Widget as Widget, MarginMixin, ORIENTATION_HORIZONTAL


def get_icon(name, size=None, theme=None):
    if not theme:
        path = os.path.expanduser("~/.config/gtk-3.0/settings.ini")
        parser = ConfigParser()
        parser.read(path)
        theme = parser.get("Settings", "gtk-icon-theme-name")
    path = IconTheme.getIconPath(name, size, theme)
    mime = Mime.get_type2(path)
    if "svg" not in mime.subtype:
        return Img.from_path(path)
    data = svg2png(url=path, output_height=size, output_width=size)
    return Img(data)


class IconText(Widget, MarginMixin):
    defaults = [
        ("font", "sans"),
        ("fontsize", None),
        ("fontshadow", None),
        ("foreground", "#fff"),
        ("icon", None),
        ("icon_size", None),
        ("margin_x", 4),
        ("margin_y", 8),
        ("markup", True),
        ("text", None),
    ]

    orientations = ORIENTATION_HORIZONTAL

    def __init__(self, **config):
        super().__init__(CALCULATED, **config)
        self.add_defaults(Widget.defaults)
        self.add_defaults(MarginMixin.defaults)
        self.add_defaults(IconText.defaults)
        self.img = None
        self.text_layout = None

    def _configure(self, qtile, bar):
        super()._configure(qtile, bar)
        if self.icon:
            self.update_icon(self.icon, self.icon_size)
        if self.text:
            self.update_text(self.text)

    def update_icon(self, icon, size=None):
        if icon == self.icon:
            return
        self.icon = icon
        old_width = self.img.width if self.img else 0
        self.img = get_icon(
            icon, self.icon_size or self.bar.height - self.margin_y * 2, self.icon_theme
        )
        if not self.img:
            return
        if self.img.width == old_width:
            self.draw()
        else:
            self.bar.draw()

    def update_text(self, text):
        if text == self.text:
            return
        self.text = text
        old_width = self.text_layout.width if self.text_layout else 0
        self.text_layout = self.drawer.textlayout(
            text,
            self.foreground,
            self.font,
            self.fontsize or self.bar.height - self.bar.height / 5,
            self.fontshadow,
            markup=self.markup,
            wrap=False,
        )
        if self.text_layout.width == old_width:
            self.draw()
        else:
            self.bar.draw()

    def draw(self):
        self.drawer.clear(self.background or self.bar.background)
        self.drawer.ctx.save()
        self.drawer.ctx.translate(self.margin_x, self.margin_y + 1)
        if self.img:
            self.drawer.ctx.set_source(self.img.pattern)
            self.drawer.ctx.paint()
        self.drawer.ctx.restore()
        if self.text_layout:
            x = self.margin_x + (self.img.width + self.margin_x) if self.img else 0
            y = self.bar.height / 2 - self.text_layout.height / 2 + 1
            self.text_layout.draw(x, y)
        self.drawer.draw(offsetx=self.offset, offsety=self.offsety, width=self.width)

    def calculate_length(self):
        return sum(
            [
                self.margin_x,
                self.img.width if self.img else 0,
                self.margin_x if self.img and self.text_layout else 0,
                self.text_layout.width if self.text_layout else 0,
                self.margin_x,
            ]
        )


class ThreadIconText(IconText):
    defaults = [("update_interval", 1)]

    def __init__(self, **config):
        super().__init__(**config)
        self.add_defaults(IconText.defaults)
        self.add_defaults(ThreadIconText.defaults)

    def timer_setup(self):
        def on_done(future):
            try:
                icon_name, text = future.result()
                self.update(icon_name, text)
            except Exception:
                pass
            if self.update_interval:
                self.timeout_add(self.update_interval, self.timer_setup)

        self.future = self.qtile.run_in_executor(self.poll)
        self.future.add_done_callback(on_done)

    def poll(self):
        pass

    def update(self, icon_name, text):
        self.update_icon(icon_name)
        self.update_text(text)
