# sourced by the ~/.local/bin daemons. POSIX sh
# daemon_lock <name>: returns 0 when we now own the lock, 1 when <name> already runs
# per user dir (not /tmp) ∴ no other user can squat it. the cache fallback survives
# reboots ∴ a pid only counts as running if that process really is <name>
daemon_lock() {
	_lock=${XDG_RUNTIME_DIR:-${XDG_CACHE_HOME:-$HOME/.cache}}/$1.lock
	mkdir -p "${_lock%/*}"
	if ! mkdir "$_lock" 2>/dev/null; then
		_pid=$(cat "$_lock/pid" 2>/dev/null) || _pid=
		# no pid yet: the owner is between its mkdir + writing the pid
		[ -z "$_pid" ] && return 1
		kill -0 "$_pid" 2>/dev/null &&
			ps -o args= -p "$_pid" 2>/dev/null | grep -qF -- "$1" && return 1
		rm -rf "$_lock"
		mkdir "$_lock" 2>/dev/null || return 1
	fi
	printf '%s\n' "$$" > "$_lock/pid"
	trap 'rm -rf "$_lock"' EXIT
}
