#!/usr/bin/python


device = "BAT0"


def get_capacity():
    with open("/sys/class/power_supply/{}/capacity".format(device)) as file:
        capacity = file.read().strip()
    return capacity


def get_status():
    with open("/sys/class/power_supply/{}/status".format(device)) as file:
        status = file.read().strip()
    return status


if __name__ == "__main__":
    try:
        capacity = get_capacity()
        print(capacity)
        status = get_status()
        print(status)
    except Exception:
        exit(1)
