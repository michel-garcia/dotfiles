#!/bin/sh

# Screen
xrandr --output DVI-D-0 --mode 1920x1080 --pos 0x0 --rotate left --output HDMI-0 --primary --mode 2560x1440 --pos 1080x286 --rotate normal --output DP-0 --off --output DP-1 --off

# Keyboard
setxkbmap -layout us -variant altgr-intl

# Background
~/.fehbg

# Compositor
picom -b --experimental-backends

# Services
sxhkd &
dunst &
udiskie &

# Environment
xsetroot -cursor_name left_ptr
exec xmonad
