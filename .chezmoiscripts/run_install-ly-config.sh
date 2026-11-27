#!/bin/sh
# ly config (etc/ly/config.ini in repo) to /etc/ly/.
# runs every apply, only asks for pw when the file changed.
set -eu
. "$CHEZMOI_SOURCE_DIR/.lib/as_root.sh"

install_root_file "$CHEZMOI_SOURCE_DIR/etc/ly/config.ini" /etc/ly/config.ini
