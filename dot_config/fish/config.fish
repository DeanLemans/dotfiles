source /usr/share/cachyos-fish-config/cachyos-config.fish

# Dean's cool shell(fish) config

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# Added by Radicle.
export PATH="$PATH:/home/void/.radicle/bin"

# pnpm
set -gx PNPM_HOME "/home/void/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# treat cd as z (zoxide the goat)
if status is-interactive
function cd
    if test (count $argv) -eq 0
        builtin cd
    else if type -q __zoxide_z
        __zoxide_z $argv
    else
        builtin cd $argv
    end
end
end

# treat cat as bat (superior)
if status is-interactive
function cat
    if type -q bat
        bat $argv
    else
        command cat $argv
    end
end
end

# yeah
if status is-interactive
function du
    dust $argv
end
end

# yeah
if status is-interactive
function ls
    if type -q eza
        eza $argv
    else
        command ls $argv
    end
end
end

# yeah
if status is-interactive
function df
    duf $argv
end
end


zoxide init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
