#!/bin/sh

dbus-update-activation-environment DISPLAY XAUTHORITY
autorandr --change
xsetroot -cursor_name left_ptr
xset b off
setxkbmap -layout us -variant altgr-intl
picom -b
udiskie &
exec qtile start

