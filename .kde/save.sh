#!/bin/sh
# kde files are templates ∴ `chezmoi re-add` skips them
# this copies the live kde files back into .kde/<machine>/
# only files that already exist there get copied. to track a new one
# create it in .kde/<machine>/ first (+ a template in dot_config if its new)
set -eu
src=$(chezmoi source-path)
machine=$(chezmoi execute-template '{{ get . "machine" | default "main" }}')
if [ ! -d "$src/.kde/$machine" ]; then
    echo "save.sh: no $src/.kde/$machine, wrong machine in chezmoi config?" >&2
    exit 1
fi
for f in "$src/.kde/$machine"/*; do
    n=$(basename "$f")
    case $n in
        kde-portals.conf) live="$HOME/.config/xdg-desktop-portal/$n" ;;
        *) live="$HOME/.config/$n" ;;
    esac
    [ -f "$live" ] && cp "$live" "$f" && echo "saved $n"
done
