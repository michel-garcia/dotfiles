from subprocess import Popen


def exec(cmd):
    Popen(cmd, shell=True)
