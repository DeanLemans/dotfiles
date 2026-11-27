#!/bin/sh
# link ~/.agents into the installed agents + start the watcher, see link-agents
set -eu
"$HOME/.local/bin/link-agents"
"$HOME/.local/bin/start-user-daemons"
