#!/bin/sh

# Screen
xrandr --output DVI-D-0 --mode 1920x1080 --pos 0x0 --rotate left
xrandr --output HDMI-0 --primary --mode 2560x1440 --pos 1080x286 --rotate normal

# Background
hsetroot -solid "#3b3735"

# Display
xsetroot -cursor_name left_ptr
xset b off

# Compositor
picom -b --experimental-backends

# Services
sxhkd &
udiskie &

# Keyboard
setxkbmap -layout us -variant altgr-intl

# Environment
# exec awesome
exec xmonad

