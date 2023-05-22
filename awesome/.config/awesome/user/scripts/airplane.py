#!/usr/bin/python
import subprocess


def get_status():
    output = subprocess.check_output([
        "nmcli", "radio", "wifi"
    ]).decode().strip()
    return "on" if output == "disabled" else "off"


def toggle():
    status = get_status()
    subprocess.check_output([
        "nmcli", "radio", "wifi",
        "off" if status == "on" else "on"
    ])


if __name__ == "__main__":
    try:
        status = get_status()
        print(status)
    except Exception:
        exit(1)
