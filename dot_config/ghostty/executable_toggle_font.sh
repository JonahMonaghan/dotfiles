#!/bin/bash

#Paths

CURRENT="$HOME/.config/ghostty/fonts/font_current.conf"
SMALL="$HOME/.config/ghostty/fonts/font_small.conf"
LARGE="$HOME/.config/ghostty/fonts/font_large.conf"

if cmp -s "$CURRENT" "$SMALL"; then
	cat "$LARGE" > "$CURRENT"
else
	cat "$SMALL" > "$CURRENT"
fi

pkill -SIGUSR2 ghostty
