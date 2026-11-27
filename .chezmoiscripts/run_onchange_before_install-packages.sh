#!/bin/sh
# installs the apps these dotfiles are for. reruns whenever this file changes.
# already installed stuff is skipped (--needed). names are arch ones ∴ on other
# systems (no pacman) it only prints the list + never fails the apply.
# DOTFILES_MACHINE comes from [scriptEnv] in chezmoi config (main or server)
set -eu
. "$CHEZMOI_SOURCE_DIR/.lib/as_root.sh"

machine=${DOTFILES_MACHINE:?"not set, run chezmoi init first"}

if [ "$machine" = main ]; then
    extra=floorp-bin
else
    extra=jre25-openjdk
fi

# repo packages (arch/cachyos)
pkgs="fish kitty zed emacs lazygit
zoxide bat eza dust duf
nemo ly godot equibop betterbird-bin
flatpak python-pipx inotify-tools
$extra"
# aur packages, paru lets you look at the PKGBUILD first
aur="wallust albert"

if command -v pacman >/dev/null 2>&1; then
    # unquoted on purpose: split into package names
    as_root pacman -S --needed $pkgs
    if command -v paru >/dev/null 2>&1; then
        paru --sudo "$(root_tool)" -S --needed $aur
    else
        echo "install-packages: no paru, skipped aur: $aur" >&2
    fi
else
    echo "install-packages: no pacman on $(uname -s), skipped. install by hand (arch names):" >&2
    echo $pkgs $aur | fold -s -w 76 | sed 's/^/    /' >&2
fi

# flatpaks (configs live in ~/.var/app)
if command -v flatpak >/dev/null 2>&1; then
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install -y --noninteractive flathub \
        com.obsproject.Studio \
        com.orama_interactive.Pixelorama
else
    echo "install-packages: no flatpak, skipped obs + pixelorama" >&2
fi

# promnesia (browser history thing, see readme)
if ! command -v promnesia >/dev/null 2>&1; then
    if command -v pipx >/dev/null 2>&1; then
        pipx install promnesia
        pipx inject promnesia browserexport sqlite_backup
    else
        echo "install-packages: no pipx, skipped promnesia" >&2
    fi
fi
