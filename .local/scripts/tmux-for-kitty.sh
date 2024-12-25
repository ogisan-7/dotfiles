#!/bin/bash
if [[ "$TERM" == "xterm-kitty" && ! "$(ps -o comm= --pid $(ps -o ppid= --pid $$))" =~ nvim ]]; then
    echo -e "neofetch\n"
fi
