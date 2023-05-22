#!/usr/bin/python
import subprocess


def get_brightness():
    try:
        return subprocess.check_output([
            "brightnessctl", "get"
        ]).decode().strip()
    except FileNotFoundError:
        return None


if __name__ == "__main__":
    try:
        brightness = get_brightness()
        print(brightness)
    except Exception:
        exit(1)
