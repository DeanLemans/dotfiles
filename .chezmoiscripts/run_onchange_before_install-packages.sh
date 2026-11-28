#!/bin/sh
# asks per app if it should be installed, installs nothing on its own
# already installed stuff isnt asked. reruns when this file changes. to get
# asked again: chezmoi state delete-bucket --bucket=entryState
# names are arch ones ∴ on other systems (no pacman) it only prints the list
# no terminal (apply from a hook ETC) = nothing installed
# DOTFILES_MACHINE comes from [scriptEnv] in chezmoi config (main or server)
set -eu
. "$CHEZMOI_SOURCE_DIR/.lib/as_root.sh"

machine=${DOTFILES_MACHINE:?"not set, run chezmoi init first"}

if ! { : </dev/tty; } 2>/dev/null; then
	echo "install-packages: no terminal, nothing asked or installed. to get asked:" >&2
	echo "    chezmoi state delete-bucket --bucket=entryState && chezmoi apply" >&2
	exit 0
fi

# "package:what its for", one per line
pkgs="fish:shell
kitty:terminal
zed:editor
emacs:editor
lazygit:git ui
zoxide:cd replacement
bat:cat replacement
eza:ls replacement
dust:du replacement
duf:df replacement
nemo:file manager
godot:game engine
equibop:discord client
betterbird-bin:mail
flatpak:for obs + pixelorama
python-pipx:for promnesia
inotify-tools:instant link-agents-watch
tmux:runs mc server consoles"
aur="wallust:colors from wallpaper
albert:launcher"
flatpaks="com.obsproject.Studio:obs
com.orama_interactive.Pixelorama:pixelorama"

[ "$machine" = main ] && pkgs="$pkgs
floorp-bin:browser"

# ly only when theres no login manager yet (plasma-login, sddm ETC)
has_login_manager() {
	[ -e /etc/systemd/system/display-manager.service ] && return 0
	for dm in plasmalogin sddm gdm lightdm greetd lemurs ly xdm; do
		PATH=$PATH:/usr/sbin:/sbin command -v "$dm" >/dev/null 2>&1 && return 0
	done
	return 1
}
has_login_manager || pkgs="$pkgs
ly:login manager"

# purpur needs java 25+, any java that new is fine
if [ "$machine" = server ]; then
	java_major=$(java -version 2>&1 | sed -n 's/.*version "\([0-9]*\).*/\1/p' | head -n 1)
	[ "${java_major:-0}" -ge 25 ] || pkgs="$pkgs
jre25-openjdk:java for the mc server"
fi

# prints names from "name:why" lines that $1 says are missing + got a yes
ask_missing_packages() { # check-command lines
	printf '%s\n' "$2" | while IFS=: read -r name why; do
		if ! "$1" "$name" && ask_yes_no "install $name ($why)?"; then
			printf '%s ' "$name"
		fi
	done
}
pacman_has_package() { pacman -Q "$1" >/dev/null 2>&1; }
flatpak_has_app() { flatpak info "$1" >/dev/null 2>&1; }

if command -v pacman >/dev/null 2>&1; then
	chosen=$(ask_missing_packages pacman_has_package "$pkgs")
	# unquoted on purpose: split into package names
	[ -n "$chosen" ] && as_root pacman -S --needed $chosen

	if command -v paru >/dev/null 2>&1; then
		chosen=$(ask_missing_packages pacman_has_package "$aur")
		[ -n "$chosen" ] && paru --sudo "$(root_tool_name)" -S --needed $chosen
	else
		echo "install-packages: no paru, skipped aur stuff" >&2
	fi
else
	echo "install-packages: no pacman on $(uname -s), install by hand if wanted (arch names):" >&2
	printf '%s\n%s\n' "$pkgs" "$aur" | sed 's/^/    /' >&2
fi

if command -v flatpak >/dev/null 2>&1; then
	chosen=$(ask_missing_packages flatpak_has_app "$flatpaks")
	if [ -n "$chosen" ]; then
		flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
		flatpak install -y --noninteractive flathub $chosen
	fi
fi

if ! command -v promnesia >/dev/null 2>&1 && command -v pipx >/dev/null 2>&1 \
	&& ask_yes_no "install promnesia (browser history, pipx)?"; then
	pipx install promnesia
	pipx inject promnesia browserexport sqlite_backup
fi
