# the deansest dean / th3seekers dotfiles

cachyos + kde plasma, fish, kitty, zed as main editor

no keys/passwords/tokens in here, if there is one its a mistake

---

## Stuff

**shell/terminal**

- fish, cd/cat/ls/du/df -> zoxide/bat/eza/dust/duf (falls back to normal ones if not installed)
- kitty, theme ANSI 1987
- wallust is in, kitty template turned off
	- wrote straight into kitty.conf, so every run replaced my whole config. probb why terminal was fucked
	- needs to write to own file (?)

**desktop**

- KDE plasma: colors/kwin/shortcuts/panels/mouse+touchpad/krunner/lockscreen/power
	- used COSMIC before, i like it (rust, open source) but wasnt finished enough for daily use, at least when i tried
- file manager is nemo, not dolphin
	- dolphin uninstalled but open/save dialog still looked like it bc thats the kde file picker -> file picker is nemo now
	- kde/qt apps (obs, krita) still use kde one, dont care enough ATM
- nemo sidebar bookmarks (music, repositories, manga, books ETC)

**editors/dev**

- zed
- emacs, [Emacs Bedrock](https://codeberg.org/ashton314/emacs-bedrock)
- godot 4.8 editor settings (not project settings, see my open source games for that)
- lazygit
- git config

**browser**

- floorp: user.js, userChrome.css, bookmarks
- addons installed by floorp policy file (`etc/floorp/policies.json`)
	- script in `.chezmoiscripts/` copies it to `/etc/floorp/policies/`, needs root, only asks when file changed
	- downside: cant uninstall them from inside floorp anymore, only disable
	- addon settings (ublock filters, violentmonkey scripts, sidebery ETC) not in here, floorp keeps them in own storage, export by hand

**why floorp and not chrome/brave/whatever?**

firefox based = more customizability, thats mostly it. other people use it so chrome doesnt become the only engine, i get it, idc that much. floorp bc workspaces + sidebar stuff

**apps**

- obs (flatpak), scenes + profiles yes, stream key no ofc
- pixelorama (flatpak), config + shortcuts + layouts
- equibop
	- pinned dms plugin stored discord ids in settings file + got pushed
	- small script now keeps pinned dms out of repo but on pc
	- `re-add` doesnt work for it anymore (see updating)
- betterbird, only layout. mail is on mailbox.org, nothing to back up
- albert (launcher, meta+space)
- promnesia
	- indexes floorp history + notes + downloads + nexus folder every hour, `~/.local/bin/promnesia-daemon` (no systemd, starts on login)
	- server only on localhost now, was 0.0.0.0 -> anyone on same wifi could look through my history
	- selfhosted bc my browsing history should be on my machine, not some companys server. thats the whole point

**ai agents**

- memories + skills for ai agents, see [dot_agents/README.md](dot_agents/README.md)

**background stuff (no systemd)**

- all plain sh in ~/.local/bin, no systemd, so should work on the bsds too (never tested (?))
- start-user-daemons starts link-agents-watch + promnesia-daemon
	- called from autostart, fish login, .profile, chezmoi apply + claude hook
	- sounds like a lot, each daemon has a lock so never runs twice
- watcher instant w/ inotifywait or fswatch, else checks every 5s

---

## Server (leftover pc)

`machine = server` in chezmoi. gets everything except floorp, own kde in `.kde/server/`

**minecraft**

- velocity proxy (`~/velocity`, port 25566) in front of purpur (`~/purpur-server`, 25565), players join on velocity
- velocity plugin: hyperzonelogin (offline + premium login). purpur has spark
- 2 secrets, both templates so never in git, values only in `~/.config/chezmoi/chezmoi.toml` on server (asked on `chezmoi init`)
	- velocity forwarding secret, in `velocity/forwarding.secret` AND `purpur-server/config/paper-global.yml`, must be same in both or nobody can join
	- purpur `management-server-secret` in `server.properties`
	- both random strings, lost -> make new ones
- not in repo: jars, world, logs, ops/whitelist/bans, hyperzonelogin db (player passwords + totp, not going on github)
- paper/purpur rewrite own yml on start, so `chezmoi diff` shows stuff sometimes, idc

**how it works**

- players connect to velocity, velocity checks the account (or hyperzonelogin does for offline players) + sends them to purpur
- purpur has `online-mode=false` bc velocity already did the login. velocity passes the player on with "modern forwarding", signed with the forwarding secret. purpur only trusts that ∴ joining purpur directly on 25565 gets you kicked
- so purpur first, velocity after. velocity without purpur = everyone gets "server not found"
- java 25 (`jre25-openjdk`). velocity 1G ram, purpur 6G (pc has 11)

**running it**

`mc` (`~/.local/bin/mc`, server only) runs both in tmux, right order:

```fish
mc start              # purpur, waits till its up, then velocity
mc stop               # velocity first (kicks players), then purpur (saves world)
mc restart
mc status
mc console purpur     # type server commands. leave with ctrl+b then d, NOT ctrl+c (kills it)
mc log velocity       # follow log
```

- "up" = the `Done (` line in `logs/latest.log`, not just port open
- each `start.sh` loops: crash or `/restart` -> back up after 5 sec. only stops for real on `mc stop` (makes a `.stop` file) or ctrl+c
- `restart-script` in spigot.yml is empty on purpose, otherwise `/restart` starts a 2nd purpur outside tmux without console
- doesnt start on boot (no systemd), `mc start` after reboot
- aikar flags for purpur, velocitys recommended ones for velocity

**updating mc**

- new jars from papermc.io (velocity) + purpurmc.org, replace `velocity.jar` / `purpur.jar`, same names
- new mc version -> update both + check plugins still work
- velocity plugins in `velocity/plugins/`, purpur ones in `purpur-server/plugins/`. jar not in repo, its config yes (`chezmoi add` the config file)

**ssh into it (over tor)**

pcs on different networks + cant port forward on that router. tailscale would work but thats a company server again -> tor onion service. any wifi, no ports open. slow but its ssh

- server, `/etc/tor/torrc` (NOT `/etc/torrc`, arch reads the tor/ one):

	```
	HiddenServiceDir /var/lib/tor/ssh/
	HiddenServicePort 22 127.0.0.1:22
	```

	then `sudo systemctl enable --now tor sshd`. .onion address is in `/var/lib/tor/ssh/hostname`
- address NOT in this repo. backup `/var/lib/tor/ssh/` somewhere private to keep same address after reinstall (its made from the key in there)
- password login off (`/etc/ssh/sshd_config.d/10-keys-only.conf`), keys only, same key as main pc
- main pc: `sudo pacman -S tor torsocks openbsd-netcat`, enable tor, in `~/.ssh/config`:

	```
	Host server
	    HostName <the address>.onion
	    User tv
	    ProxyCommand nc -X 5 -x 127.0.0.1:9050 %h %p
	```

	then `ssh server` / `scp file server:~/`. first connect ≈ 10-30 sec

**updating the server**

main pc pushes to github, server only pulls. repo is public -> no git login on server

```fish
chezmoi update --apply=false
chezmoi diff
chezmoi apply
```

- first one only pulls, doesnt touch files. `apply --exclude=scripts` skips install scripts
- `chezmoi update` alone = pull + apply, fine if i dont care what changes
- dont re-add on server before pulling, copies server version over source -> undoes whatever came from main
- mc configs: change on main, push, pull on server. changing on server = re-add + push from there, needs github login on server

---

## New machine (not tested on a brand new machine yet, cant be bothered)

- [ ] install chezmoi
- [ ] `chezmoi init deanlemans/dotfiles`, asks `main` or `server` (server = minecraft box, asks for the 2 mc secrets)
- [ ] `chezmoi diff` then `chezmoi apply`
- [ ] apps: `.chezmoiscripts/run_onchange_before_install-packages.sh` asks y/N per app thats missing (pacman + paru + flatpak + pipx), installs nothing without yes. ly only asked when theres no login manager yet, java only when theres no java 25+
	- said no + want it after all: `chezmoi state delete-bucket --bucket=entryState` then apply again
	- ly/floorp config to /etc also asks first, only when the file changed
- [ ] type pw in popup (scripts use run0/polkit, falls back to pkexec > doas > sudo, see `.lib/as_root.sh`)
- [ ] main only: restart floorp, check `about:policies` if addons are there
- [ ] sign into mailbox.org in betterbird
- [ ] redownload pixelorama extensions (discordrpc, timetracking), theyre binaries
- [ ] agents: nothing, apply runs link-agents. codex/opencode installed later -> watcher links it within 5 min

---

## Updating

- changed smth already tracked > `chezmoi re-add`, `chezmoi cd`, commit, push
- new file > `chezmoi add <path>`
- check > `chezmoi status` or `chezmoi diff --reverse`
- equibop is exception, re-add skips it, use:

```fish
printf %s (jq --indent 4 '.plugins.PinDMs.userBasedCategoryList = {}' ~/.config/equibop/settings/settings.json | string collect) > (chezmoi source-path)/dot_config/private_equibop/settings/.settings.base.json
```

- kde per machine: `.kde/main/` + `.kde/server/`, picked by `machine` in chezmoi config (asked on `chezmoi init`). templates so re-add skips them, save w/ `sh (chezmoi source-path)/.kde/save.sh`
- server also skips floorp
- kde/godot/pixelorama/betterbird/floorp bookmarks rewrite own files whenever -> `chezmoi status` never empty. idc, re-add when i want it saved
- `chezmoi apply` always asks before rewriting local stuff
- `chezmoi apply --exclude=scripts` = only files, no install scripts
- source changed somewhere else (pull, agent edited it)? apply first, re-add after, otherwise re-add copies pc version over it
- chezmoi doesnt delete files on other machines when deleted here -> empty remove_ files for that. delete those once every machine applied

---

## Current Tasks

**later**

- [ ] export addon settings (ublock/violentmonkey/sidebery/leechblock/dark reader/libredirect) + put here (if nothing private in)
- [ ] fix wallust kitty template so it writes to own file
- [ ] create godot starter project, put on github, link here
- [ ] dark css for promnesia sidebar maybe
- [ ] (bi?)monthly `chezmoi re-add` so this doesnt go stale for months again
- [ ] promnesia timer pointless on server (no floorp), skip it there
- [ ] backup `/var/lib/tor/ssh/` somewhere private

**done**

- [x] set up chezmoi properly + sync with whats actually on pc
- [x] swap cosmic config for kde
- [x] get rid of dolphin file picker
- [x] per machine kde + minecraft server box
- [x] ssh into server over tor
- [x] promnesia browser history + hourly index
- [x] get discord ids out of repo history

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
- [chezmoi source state attributes](https://www.chezmoi.io/reference/source-state-attributes/) (the `remove_` thing)
- [chezmoi update](https://www.chezmoi.io/reference/commands/update/)
- [inotify-tools](https://github.com/inotify-tools/inotify-tools)
- [fswatch](https://github.com/emcrisostomo/fswatch)
