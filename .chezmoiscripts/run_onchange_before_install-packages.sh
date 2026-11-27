#!/bin/sh
# installs the apps these dotfiles are for. reruns whenever this file changes.
# already installed stuff is skipped (--needed).
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
as_root pacman -S --needed \
    fish kitty zed emacs lazygit \
    zoxide bat eza dust duf \
    nemo ly godot equibop betterbird-bin \
    flatpak python-pipx \
    inotify-tools \
    "$extra"

# aur packages, paru lets you look at the PKGBUILD first
paru --sudo "$(root_tool)" -S --needed wallust albert

# flatpaks (configs live in ~/.var/app)
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y --noninteractive flathub \
    com.obsproject.Studio \
    com.orama_interactive.Pixelorama

# promnesia (browser history thing, see readme)
if ! command -v promnesia >/dev/null 2>&1; then
    pipx install promnesia
    pipx inject promnesia browserexport sqlite_backup
fi
