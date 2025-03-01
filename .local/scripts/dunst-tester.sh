#!/bin/bash

CONFIG_FILES="$HOME/.config/dunst/dunstrc"

trap "killall dunst" EXIT

while true; do
    dunst &
    notify-send "help0"
    inotifywait -e create,modify $CONFIG_FILES
    killall dunst
done

