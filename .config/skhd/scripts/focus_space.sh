#!/usr/bin/env sh
space_wanted=$1

keymaps=(
    "shift - f"        # display 1
    "shift + ctrl - f" # display 2
)
space=$(yabai -m query --displays --display | jq -r ".spaces[$(expr $space_wanted - 1)]")
current_display=$(yabai -m query --displays --display | jq -r .index)

skhd --key "${keymaps[$(expr $current_display - 1)]}$1"
