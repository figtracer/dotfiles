# Enable completion features
autoload -Uz compinit
compinit

# Set options for better completion behavior
setopt COMPLETE_IN_WORD    # Complete from both ends of a word
setopt ALWAYS_TO_END       # Move cursor to end of word after completion
setopt AUTO_MENU          # Show completion menu on successive tab press
setopt AUTO_LIST          # Automatically list choices on ambiguous completion

# Configure completion styles
zstyle ':completion:*' menu select                 # Enable menu selection
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive completion
zstyle ':completion:*' verbose yes                 # Provide more information in completion
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'

# Path to your oh-my-zsh installation.
export ZSH=/Users/gustavo/.oh-my-zsh

# Reevaluate the prompt string each time it's displaying a prompt
setopt prompt_subst
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload bashcompinit && bashcompinit
autoload -Uz compinit
compinit

source <(kubectl completion zsh)
complete -C '/usr/local/bin/aws_completer' aws
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export EDITOR=/opt/homebrew/bin/nvim

# Compiler flags for multi-target compilation compatability
export LDFLAGS="-L/opt/homebrew/opt/pcsc-lite/lib"
export CPPFLAGS="-I/opt/homebrew/opt/pcsc-lite/include"

# SSH and Trezor
export SSH_AUTH_SOCK=${HOME}/.trezor-agent/S.ssh

# Aliases
alias ls="ls -alh --color=auto"
alias la=tree
alias cat=bat

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# GO
export GOPATH="/opt/homebrew/Cellar/go"
export GOCACHE="$HOME/Library/Caches/go-build"

# VIM
alias v="/opt/homebrew/bin/nvim"

# Nmap
alias nm="nmap -sC -sV -oN nmap"
alias cl='clear'

# K8S
export KUBECONFIG=~/.kube/config
alias k="kubectl"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kl="kubectl logs"
alias kgpo="kubectl get pod"
alias kgd="kubectl get deployments"
alias kc="kubectx"
alias kns="kubens"
alias kl="kubectl logs -f"
alias ke="kubectl exec -it"
alias kcns='kubectl config set-context --current --namespace'
alias podname=''

# HashiCorp Vault
export VAULT_ADDR=https://localhost:8200

# HTTP requests with xh!
alias http="xh"

# VI Mode!!!
bindkey jj vi-cmd-mode

export PATH=/opt/homebrew/bin:$PATH
alias mat='osascript -e "tell application \"System Events\" to key code 126 using {command down}" && tmux neww "cmatrix"'

function ranger {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
        command
        ranger
        --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )
    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}
alias rr='ranger'

# navigation
cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

eval "$(zoxide init zsh)"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# Source oh-my-zsh at the end
source $ZSH/oh-my-zsh.sh

# Added by Windsurf
export PATH="/Users/gustavo/.codeium/windsurf/bin:$PATH"
export PATH=$PATH:/Users/gustavo/.spicetify
export PATH="$HOME/.asdf/shims:$PATH"
# Alias for running starkup installer
alias starkup="curl --proto '=https' --tlsv1.2 -sSf https://sh.starkup.sh | sh -s --"
export PATH="$PATH:/Users/gustavo/.aztec/bin"
export PATH="${HOME}/.bb:${PATH}"

export NARGO_HOME="/Users/gustavo/.nargo"

export PATH="$PATH:$NARGO_HOME/bin"
export PATH="/Users/gustavo/.bb:$PATH"
export PATH="/Users/gustavo/.bb:$PATH"
export PATH="/Users/gustavo/.bb:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

alias cfmt="cargo +nightly fmt --all"
# Simple repeat: optional count, then infinite
function repeat() {
    local count="$1"
    if [[ -n "$count" && "$count" =~ ^[0-9]+$ ]]; then
        shift
        for ((i = 1; i <= count; i++)); do
            "$@"
        done
    else
        while true; do
            "$@"
        done
    fi
}
