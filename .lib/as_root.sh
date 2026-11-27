# sourced by .chezmoiscripts. runs a command as root with whatever is installed,
# prefers polkit (run0 / pkexec, kde shows a password popup) over sudo.
# order: run0 (systemd) > pkexec (polkit) > doas (openbsd + others) > sudo
# > pfexec (illumos/solaris rbac) > su (always there, asks root pw)
as_root() {
    if command -v run0 >/dev/null 2>&1; then
        run0 "$@"
    elif command -v pkexec >/dev/null 2>&1; then
        pkexec "$@"
    elif command -v doas >/dev/null 2>&1; then
        doas "$@"
    elif command -v sudo >/dev/null 2>&1; then
        sudo "$@"
    elif command -v pfexec >/dev/null 2>&1; then
        pfexec "$@"
    else
        # su only takes 1 command string ∴ quote every arg for sh
        _cmd=
        for _a in "$@"; do
            _cmd="$_cmd '$(printf '%s' "$_a" | sed "s/'/'\\\\''/g")'"
        done
        su root -c "$_cmd"
    fi
}

# the name of that tool, for paru --sudo (su cant work there, its not sudo-like)
root_tool() {
    for t in run0 pkexec doas sudo pfexec; do
        if command -v "$t" >/dev/null 2>&1; then
            echo "$t"
            return
        fi
    done
}

# copy $1 to $2 as root, only if different (so it only asks for pw when needed)
install_root_file() {
    if ! cmp -s "$1" "$2"; then
        as_root sh -c 'mkdir -p "$(dirname "$2")" && cp "$1" "$2" && chmod 644 "$2"' sh "$1" "$2"
    fi
}

# where the os keeps config of non-base software: linux /etc, bsds /usr/local/etc,
# illumos/solaris /etc (pkgsrc would be /opt/local/etc, set ETC_PREFIX then)
etc_prefix() {
    if [ -n "${ETC_PREFIX:-}" ]; then
        echo "$ETC_PREFIX"
        return
    fi
    case $(uname -s) in
        *BSD|DragonFly) echo /usr/local/etc ;;
        *) echo /etc ;;
    esac
}
