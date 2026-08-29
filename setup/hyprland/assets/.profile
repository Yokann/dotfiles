#!/bin/sh

set -a
. "$HOME/.config/user-dirs.dirs"
set +a

if [ -n "$(ls "$HOME"/.config/profile.d 2>/dev/null)" ]; then
    for f in "$HOME/.config/profile.d"/*; do
        [ -r "$f" ] && . "$f"
    done
fi
