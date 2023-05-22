#!/usr/bin/python
import re
import subprocess
import sys


def get_sink_volume(sink):
    output = subprocess.check_output([
        "pactl", "get-sink-volume",
        sink or "@DEFAULT_SINK@"
    ]).decode()
    volume = re.search("([0-9]+)%", output).group(1)
    return volume


def set_sink_volume(sink, volume):
    subprocess.check_output([
        "pactl", "set-sink-volume",
        sink or "@DEFAULT_SINK@",
        volume
    ])


def get_sink_mute(sink):
    output = subprocess.check_output([
        "pactl", "get-sink-mute",
        sink or "@DEFAULT_SINK@"
    ]).decode()
    mute = re.search(":\\s(\\w+)", output).group(1)
    return mute


def set_sink_mute(sink, value):
    subprocess.check_output([
        "pactl", "set-sink-mute",
        sink or "@DEFAULT_SINK@",
        value
    ])


if __name__ == "__main__":
    try:
        if len(sys.argv) == 1:
            volume = get_sink_volume(None)
            print(volume)
            mute = get_sink_mute(None)
            print("unmuted" if mute != "yes" else "muted")
        elif len(sys.argv) >= 2:
            if sys.argv[1] == "set":
                set_sink_volume(None, sys.argv[2])
            elif sys.argv[1] == "toggle":
                set_sink_mute(None, "toggle")
    except Exception:
        exit(1)
