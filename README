# dotfiles

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
- addons get installed by floorp policy file, a script in `.chezmoiscripts/` that puts it in `/etc/floorp/policies/` so needs sudo. (downside is you cant uninstall them from inside floorp anymore, only disable)
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
  - indexes floorp history + notes + downloads + nexus folder every hour with systemd timer
  - server only listens on localhost now, was on 0.0.0.0 before which means anyone on same wifi could look through my history
  - selfhosting this bc i want my browsing history on my own machine and not on some companys server, thats kinda the whole point of it

---

## New machine (tbh i havnt tested in on a brand new machine, cant be bothered)

- [ ] install chezmoi
- [ ] `chezmoi init --apply deanlemans/dotfiles`
- [ ] type sudo pw when it asks (floorp addon policy)
- [ ] restart floorp, check `about:policies` to see if addons are there
- [ ] sign into mailbox.org in betterbird
- [ ] `pipx install promnesia` then `pipx inject promnesia browserexport sqlite_backup`
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

**done**

- [x] set up chezmoi propperly + sync everything with whats actually on pc
- [x] swap cosmic config for kde
- [x] get rid of the dolphin file picker
- [x] promnesia browser history + hourly index
- [x] get discord ids out of the repo history

---

## References

- [chezmoi](https://www.chezmoi.io)
- [Manage different types of file - chezmoi](https://www.chezmoi.io/user-guide/manage-different-types-of-file/) (modify scripts, used for the equibop thing)
- [CachyOS](https://cachyos.org)
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
