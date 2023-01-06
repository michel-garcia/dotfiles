#!/bin/sh

autorandr --change
xsetroot -cursor_name left_ptr
xset b off
setxkbmap -layout us -variant altgr-intl
picom -b
sxhkd &
udiskie &
exec awesome

