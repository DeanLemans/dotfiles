#!/bin/sh
# kde files are templates now, so `chezmoi re-add` skips them.
# this copies the live kde files back into .kde/<machine>/.
# only files that already exist there get copied; to start tracking a new one,
# create it in .kde/<machine>/ first (and add a template in dot_config if its new).
set -eu
src=$(chezmoi source-path)
machine=$(chezmoi execute-template '{{ get . "machine" | default "main" }}')
for f in "$src/.kde/$machine"/*; do
    n=$(basename "$f")
    case $n in
        kde-portals.conf) live="$HOME/.config/xdg-desktop-portal/$n" ;;
        *) live="$HOME/.config/$n" ;;
    esac
    [ -f "$live" ] && cp "$live" "$f" && echo "saved $n"
done
