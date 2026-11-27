# the deansest dean / th3seekers dotfiles

My stack is cachyos + kde plasma, fish, kitty, zed as main editor.

no keys/passwords/tokens should be in here, if there is thats mistake.

---

## Stuff

**shell/terminal**

- fish, with cd/cat/ls/du/df swapped for zoxide/bat/eza/dust/duf (falls back to normal ones if not installed)
- kitty, theme is ANSI 1987
- wallust is in but kitty template is turned off, was set to write straight into kitty.conf so every time it ran replaced my whole config, which probb why terminal was fucked. need redo so it writes to its own (file (?))

**desktop**

- KDE plasma: colors/kwin/shortcuts/panels/mouse+touchpad/krunner/lockscreen/power
    - used COSMIC before this, its cool and i like that its rust and open source but wasnt finished enough for daily use, at least when i tried
- file manager is nemo, not dolphin. dolphin uninstalled but open/save dialog in every app still looked like it bc thats the kde file picker, so file picker is now nemo. kde/qt apps like obs and krita still use kde one. ( dont care enough to change that ATM)
- nemo sidebar bookmarks (music, repositories, manga, books ETC)

**editors/dev**

- zed
- emacs, its [Emacs Bedrock](https://codeberg.org/ashton314/emacs-bedrock)
- godot 4.8 editor settings (not project setting, just go search my open source games for that
- lazygit
- git config

**browser**

- floorp: user.js, userChrome.css, bookmarks
- addons get installed by floorp policy file (`etc/floorp/policies.json`), a script in `.chezmoiscripts/` copies it to `/etc/floorp/policies/` so needs root, only asks when the file changed. (downside is you cant uninstall them from inside floorp anymore, only disable)
    - addon *settings* (ublock filters, violentmonkey scripts, sidebery ETC) are not in here, floorp keeps them in own storage so id have to export them by hand

**why floorp and not chrome/brave/whatever?**

firefox based browsers have more custimizability, thats mostly what it , but other people use it bc chrome must not become the browser engine, which i get, but personally idc about that that much. floorp specifically bc of workspaces and the sidebar stuff, and custimizability, and fixes i think.

**apps**

- obs (flatpak) scenes and profiles yes, stream key no ofc
- pixelorama (flatpak), config + shortcuts + layouts
- equibop. pinned dms plugin was storing discord ids in settings file and got pushed, so now small script that keeps pinned dms out of repo but keeps them on pc. annoying bc `re-add` doesnt work anymore, (see updating)
- betterbird, only layout. mail is on mailbox.org anyway so theres nothing to back up there
- albert (launcher, meta+space)
- promnesia
  - indexes floorp history + notes + downloads + nexus folder every hour with `~/.local/bin/promnesia-daemon` (no systemd needed, starts on login)
  - server only listens on localhost now, was on 0.0.0.0 before which means anyone on same wifi could look through my history
  - selfhosting this bc i want my browsing history on my own machine and not on some companys server, thats kinda the whole point of it

---

## Server (shitty leftover pc)

`machine = server` in chezmoi. gets everything except floorp, has its own kde in `.kde/server/`

**minecraft**

- velocity proxy (`~/velocity`, port 25566) in front of purpur (`~/purpur-server`, 25565). players join on velocity
- velocity plugin: hyperzonelogin (offline + premium login). purpur has spark
- 2 secrets, both are templates so they never end up in git, values only live in `~/.config/chezmoi/chezmoi.toml` on the server (asked on `chezmoi init`):
  - velocity forwarding secret, is in `velocity/forwarding.secret` AND `purpur-server/config/paper-global.yml`, has to be same in both or nobody can join
  - purpur `management-server-secret` in `server.properties`
  - both are just random strings, if lost just make new ones
- not in repo: jars, world, logs, ops/whitelist/bans, and the hyperzonelogin db (player passwords + totp, def not going on github)
- paper/purpur rewrite their own yml on start so `chezmoi diff` shows stuff sometimes, idc

**ssh into it (over tor)**

pcs are on different networks and i cant port forward on that router. tailscale would work but thats a company server again, so its a tor onion service instead. works from any wifi, no ports open. slow but its ssh, who cares

- server: in `/etc/tor/torrc` (NOT `/etc/torrc`, arch reads the tor/ one):

  ```
  HiddenServiceDir /var/lib/tor/ssh/
  HiddenServicePort 22 127.0.0.1:22
  ```

  then `sudo systemctl enable --now tor sshd`. the .onion address is in `/var/lib/tor/ssh/hostname`
- address is NOT in this repo. backup `/var/lib/tor/ssh/` somewhere private if i want to keep the same address after reinstall, its made from the key in there
- password login is off (`/etc/ssh/sshd_config.d/10-keys-only.conf`), keys only. same ssh key as main pc
- main pc: `sudo pacman -S tor torsocks openbsd-netcat`, enable tor, and this in `~/.ssh/config`:

  ```
  Host server
      HostName <the address>.onion
      User tv
      ProxyCommand nc -X 5 -x 127.0.0.1:9050 %h %p
  ```

  then just `ssh server` / `scp file server:~/`. first connect takes like 10-30 sec

---

## New machine (tbh i havnt tested in on a brand new machine, cant be bothered)

- [ ] install chezmoi
- [ ] `chezmoi init deanlemans/dotfiles`, it asks `main` or `server` (server = minecraft box, asks for the 2 mc secrets)
- [ ] `chezmoi diff` then `chezmoi apply`
- [ ] type pw in the popup when it asks (scripts use run0/polkit, falls back to pkexec > doas > sudo, see `.lib/as_root.sh`), apps get installed by `.chezmoiscripts/run_onchange_before_install-packages.sh` (pacman + paru + flatpak + pipx)
- [ ] main only: restart floorp, check `about:policies` to see if addons are there
- [ ] sign into mailbox.org in betterbird
- [ ] redownload pixelorama extensions (discordrpc, timetracking), (theyre binaries)

---

## Updating

- changed smth that is already tracked > `chezmoi re-add`, then `chezmoi cd`, commit, push
- new file > `chezmoi add <path>`
- check =  `chezmoi status` or `chezmoi diff --reverse`
- equibop is exception, re-add skips, use this:

```fish
printf %s (jq --indent 4 '.plugins.PinDMs.userBasedCategoryList = {}' ~/.config/equibop/settings/settings.json | string collect) > (chezmoi source-path)/dot_config/private_equibop/settings/.settings.base.json
```

- kde is per machine now: `.kde/main/` and `.kde/server/`, picked by `machine` in chezmoi config (asked on `chezmoi init`). templates so re-add skips them, save with `sh (chezmoi source-path)/.kde/save.sh`
- server machine also skips floorp
- kde/godot/pixelorama/betterbird/floorp bookmarks all rewrite own files whenever, `chezmoi status` is never empty. idk + idc its fine, just re-add when i want it saved
- `chezmoi apply` always asks before rewriting local stuff

---


---

## Current Tasks

**later**

- [ ] export addon settings (ublock/violentmonkey/sidebery/leechblock/dark reader/libredirect) and put them here (if nothing private in)
- [ ] fix wallust kitty template so it writes to own file
- [ ] create and put godot starter project on github, paste link here
- [ ] dark css for promnesia sidebar maybe
- [ ] (bi?)monthly `chezmoi re-add` so this doesnt go stale for months again
- [ ] hyperzonelogin `backend-server.conf` says `post-auth-default-server=play` but theres no `play` server in velocity.toml, change to `purpur`
- [ ] promnesia timer is pointless on server (no floorp), skip it there
- [ ] backup `/var/lib/tor/ssh/` somewhere private

**done**

- [x] set up chezmoi propperly + sync everything with whats actually on pc
- [x] swap cosmic config for kde
- [x] get rid of the dolphin file picker
- [x] per machine kde + minecraft server box
- [x] ssh into server over tor
- [x] promnesia browser history + hourly index
- [x] get discord ids out of the repo history

---

## References

- [chezmoi](https://www.chezmoi.io)
- [Manage different types of file - chezmoi](https://www.chezmoi.io/user-guide/manage-different-types-of-file/) (modify scripts, used for the equibop thing)
- [CachyOS](https://cachyos.org)
- [Velocity](https://papermc.io/software/velocity)
- [Purpur](https://purpurmc.org)
- [Tor onion services setup](https://community.torproject.org/onion-services/setup/)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- <https://explosion-mental.codeberg.page/wallust/>
- [Emacs Bedrock](https://codeberg.org/ashton314/emacs-bedrock)
- [Floorp](https://floorp.app)
- [Policy Templates for Firefox](https://mozilla.github.io/policy-templates/) (floorp uses the same policies)
- [xdg-desktop-portal](https://github.com/flatpak/xdg-desktop-portal)
- [Equibop](https://github.com/Equicord/Equibop)
- [Betterbird](https://www.betterbird.eu)
- <https://pixelorama.org>
- [promnesia](https://github.com/karlicoss/promnesia)
- [HPI](https://github.com/karlicoss/HPI) (promnesia uses this for reading browser history)
- [browserexport](https://github.com/purarue/browserexport)
