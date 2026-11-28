#!/bin/sh
# floorp addons via policy file (etc/floorp/policies.json in repo)
# runs every apply, only asks for pw when the file changed. skipped when floorp
# isnt installed. floorp (like firefox) reads <etc>/floorp/policies/policies.json
set -eu
. "$CHEZMOI_SOURCE_DIR/.lib/as_root.sh"

if ! command -v floorp >/dev/null 2>&1; then
    exit 0
fi
install_root_file "$CHEZMOI_SOURCE_DIR/etc/floorp/policies.json" "$(etc_prefix)/floorp/policies/policies.json"
