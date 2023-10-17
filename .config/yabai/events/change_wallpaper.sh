#! /usr/bin/env zsh

yabai -m signal --add event=space_changed action="$HOME/.config/yabai/scripts/change_wallpaper.sh $NIX_CONFIG/wallpaper.jpg"
