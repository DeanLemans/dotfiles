#!/bin/sh
# floorp addons via policy file (etc/floorp/policies.json in repo).
# runs every apply, only asks for pw when the file changed.
set -eu
. "$CHEZMOI_SOURCE_DIR/.lib/as_root.sh"

install_root_file "$CHEZMOI_SOURCE_DIR/etc/floorp/policies.json" /etc/floorp/policies/policies.json
