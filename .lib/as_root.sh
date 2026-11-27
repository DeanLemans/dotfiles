# sourced by .chezmoiscripts. runs a command as root with whatever is installed,
# prefers polkit (run0 / pkexec, kde shows a password popup) over sudo.
as_root() {
    if command -v run0 >/dev/null 2>&1; then
        run0 "$@"
    elif command -v pkexec >/dev/null 2>&1; then
        pkexec "$@"
    elif command -v doas >/dev/null 2>&1; then
        doas "$@"
    else
        sudo "$@"
    fi
}

# the name of that tool, for paru --sudo
root_tool() {
    for t in run0 pkexec doas sudo; do
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
