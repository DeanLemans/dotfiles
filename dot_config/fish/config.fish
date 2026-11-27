# cachyos only, other systems dont have it
if test -f /usr/share/cachyos-fish-config/cachyos-config.fish
    source /usr/share/cachyos-fish-config/cachyos-config.fish
end

# Dean's cool shell(fish) config

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

set -gx PNPM_HOME $HOME/.local/share/pnpm
set -gx BUN_INSTALL $HOME/.bun
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set -gx GHCUP_INSTALL_BASE_PREFIX $HOME

fish_add_path -g $PNPM_HOME $BUN_INSTALL/bin $HOME/.cabal/bin $HOME/.ghcup/bin
fish_add_path -ga $HOME/.radicle/bin

if status is-interactive
    if type -q zoxide
        zoxide init fish | source
    end

    # treat cd as z (zoxide the goat)
    function cd
        if test (count $argv) -eq 0
            builtin cd
        else if type -q __zoxide_z
            __zoxide_z $argv
        else
            builtin cd $argv
        end
    end

    # treat cat as bat (superior)
    function cat
        if type -q bat
            bat $argv
        else
            command cat $argv
        end
    end

    function ls
        if type -q eza
            eza $argv
        else
            command ls $argv
        end
    end

    function du
        if type -q dust
            dust $argv
        else
            command du $argv
        end
    end

    function df
        if type -q duf
            duf $argv
        else
            command df $argv
        end
    end

    # treat yay as paru (only one aur helper needed)
    function yay --wraps paru
        if type -q paru
            paru $argv
        else
            command yay $argv
        end
    end
end
