from functools import reduce
from subprocess import Popen
from Xlib.display import Display


def launch(cmd):
    Popen(cmd, shell=True)


def get_screen_count():
    display = Display()
    screen = display.screen()
    resources = screen.root.xrandr_get_screen_resources()

    def callback(total, output):
        monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
        monitor.preferred = getattr(monitor, "preferred", False)
        monitor.num_preferred = getattr(monitor, "num_preferred", False)
        if monitor.preferred or monitor.num_preferred:
            total += 1
        return total

    return reduce(callback, resources.outputs, 0)
