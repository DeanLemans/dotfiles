# keep claude memory linked into new delta worktrees, also on headless boxes
# (desktops start it via xdg autostart too, the lock keeps it at 1 instance)
if status is-login; and test -x ~/.local/bin/link-delta-memory-watch
    nohup ~/.local/bin/link-delta-memory-watch </dev/null >/dev/null 2>&1 &
    disown
end
