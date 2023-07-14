#!/usr/bin/python
import subprocess


temperature = 3500


def is_enabled():
    output = subprocess.check_output(["xsnst", "--status"]).decode()
    return output == "enabled"


def enable():
    subprocess.check_output(["xsnst", "--enable", str(temperature)])


def disable():
    subprocess.check_output(["xsnst", "--disable"])


def toggle():
    enabled = is_enabled()
    if enabled:
        disable()
    else:
        enable()


if __name__ == "__main__":
    enabled = is_enabled()
    print("enabled" if enabled else "disabled")
