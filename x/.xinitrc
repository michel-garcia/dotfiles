#!/bin/sh

autorandr --change
hsetroot -solid "#3b3735"
xsetroot -cursor_name left_ptr
xset b off
setxkbmap -layout us -variant altgr-intl
picom -b
sxhkd &
udiskie &
exec xmonad

