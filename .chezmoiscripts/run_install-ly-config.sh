#!/bin/sh
# ly config (etc/ly/config.ini in repo) to /etc/ly/.
# runs every apply, only asks for pw when the file changed.
# linux only: the config has linux paths (/usr/bin/X, /usr/share/xsessions,
# brightnessctl) ∴ on a bsd it would break the login manager. skipped when ly
# isnt installed (sbin isnt always in a users PATH ∴ checked too).
set -eu
. "$CHEZMOI_SOURCE_DIR/.lib/as_root.sh"

[ "$(uname -s)" = Linux ] || exit 0
PATH=$PATH:/usr/sbin:/sbin command -v ly >/dev/null 2>&1 || exit 0
install_root_file "$CHEZMOI_SOURCE_DIR/etc/ly/config.ini" /etc/ly/config.ini
