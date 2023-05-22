#!/usr/bin/python
import re
import subprocess
import sys


temperature = 3500


def is_active():
    output = subprocess.check_output(["xrandr", "--verbose"]).decode()
    match = re.search("Gamma:\\s+([0-9.]+):([0-9.]+):([0-9.]+)", output)
    r, g, b = match.groups()
    return float(r) != 1 or float(g) != 1 or float(b) != 1


def enable():
    subprocess.check_output(["redshift", "-O", str(temperature)])


def disable():
    subprocess.check_output(["redshift", "-x"])


def toggle():
    active = is_active()
    if active:
        disable()
    else:
        enable()


if __name__ == "__main__":
    active = is_active()
    print("active" if active else "inactive")
