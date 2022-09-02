#!/bin/sh

# Screen
xrandr --output DVI-D-0 --mode 1920x1080 --pos 0x0 --rotate left --output HDMI-0 --primary --mode 2560x1440 --pos 1080x286 --rotate normal --output DP-0 --off --output DP-1 --off

# Display
xsetroot -cursor_name left_ptr
xset b off

# Compositor
picom -b --experimental-backends

# Background
~/.fehbg

# Services
sxhkd &
# dunst &
udiskie &

# Keyboard
setxkbmap -layout us -variant altgr-intl

# Environment
# exec xmonad
exec awesome

