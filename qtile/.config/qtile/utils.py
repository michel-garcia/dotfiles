from subprocess import Popen


def launch(cmd):
    Popen(cmd, shell=True)
