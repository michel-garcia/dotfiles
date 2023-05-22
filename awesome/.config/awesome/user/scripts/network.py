#!/usr/bin/python
import subprocess


TYPE_WIRED = "ethernet"
TYPE_WIRELESS = "wifi"
TYPE_LOOPBACK = "loop"


class Interface():
    device = None
    type = None

    def __init__(self, device):
        self.device = device


def get_interface_list():
    output = subprocess.check_output([
        "nmcli", "--get-values",
        ",".join(["general.device", "general.type", "general.connection"]),
        "device", "show"
    ]).decode()
    chunks = output.strip().split("\n\n")
    interfaces = []
    for chunk in chunks:
        parts = chunk.split("\n")
        if len(parts) < 3:
            parts.append(None)
        device, type, ssid = parts
        interface = Interface(device)
        interface.type = type
        if interface.type == TYPE_WIRELESS:
            interface.ssid = ssid
            interface.signal = 0
        if interface.type != TYPE_LOOPBACK:
            interfaces.append(interface)
    return interfaces


def get_wired_interface():
    interfaces = get_interface_list()
    for interface in interfaces:
        if interface.type == TYPE_WIRED:
            return interface


def get_wireless_interface():
    interfaces = get_interface_list()
    for interface in interfaces:
        if interface.type == TYPE_WIRELESS:
            return interface


def get_wifi_signal():
    output = subprocess.check_output([
        "nmcli", "--get-values",
        ",".join(["ap.in-use", "ap.signal"]),
        "device", "show"
    ]).decode()
    lines = output.strip().splitlines()
    try:
        index = lines.index("*")
        return lines[index + len(lines) // 2]
    except ValueError:
        return None


if __name__ == "__main__":
    try:
        interface = get_wired_interface()
        if not interface:
            interface = get_wireless_interface()
            if not interface:
                exit(1)
        if interface.type == TYPE_WIRELESS:
            interface.signal = get_wifi_signal()
            if not interface.signal:
                exit(1)
        print(interface.type)
        print(interface.ssid)
        print(interface.signal)
    except Exception:
        exit(1)
