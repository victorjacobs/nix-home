any-nix-shell zsh --info-right | source /dev/stdin

function hm () {
    home-manager --flake ~/dev/nix-home#vjacobs $@
}

function gir () {
    cd $(git rev-parse --show-cdup)
}

if type "eza" > /dev/null; then
    alias ls="eza -l"
else
    alias ls="ls --color=auto -lh"
fi

if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/go" ]; then
    export PATH="$HOME/go/bin:$PATH"
    export GOPATH="$HOME/go"
fi

if type "fzf" > /dev/null; then
    source <(fzf --zsh)
fi

if type "zoxide" > /dev/null; then
    eval "$(zoxide init zsh)"
fi

if type "direnv" > /dev/null; then
    eval "$(direnv hook zsh)"
fi

if type "kubectl" > /dev/null; then
    alias k="kubectl"
fi

if [ -d "/opt/homebrew/opt/rustup/bin" ]; then
    export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
fi

if [ -d "/Applications/Tailscale.app/Contents/MacOS" ]; then
    alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi

if type "starship" > /dev/null; then
    eval "$(starship init zsh)"
fi

if [[ -n "$SSH_CONNECTION" ]]; then
    host_display="@%m"
else
    host_display=""
fi

PROMPT="[%F{green}%n${host_display}%f:%F{cyan}%~%f]%# "

# vim mode
set -o vi
bindkey -v '^?' backward-delete-char

export EDITOR="vim"
export GPG_TTY=$(tty)

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt autocd
autoload -U compinit; compinit

# History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt share_history          # share command history data
