# --- Completion ---
autoload -Uz compinit && compinit
autoload bashcompinit && bashcompinit

setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt AUTO_MENU
setopt AUTO_LIST
setopt prompt_subst

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'

# --- Oh My Zsh ---
export ZSH=/Users/gustavo/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# --- Shell Plugins ---
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept

# --- Starship ---
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# --- Environment ---
export LANG=en_US.UTF-8
export EDITOR=/opt/homebrew/bin/nvim

# --- Toolchain Flags ---
export LDFLAGS="-L/opt/homebrew/opt/pcsc-lite/lib"
export CPPFLAGS="-I/opt/homebrew/opt/pcsc-lite/include"

# --- SSH (Trezor) ---
export SSH_AUTH_SOCK=${HOME}/.trezor-agent/S.ssh

# --- Aliases ---
alias ls="ls -alh --color=auto"
alias la=tree
alias cat=bat
alias cl='clear'
alias v="/opt/homebrew/bin/nvim"

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias d="git diff"
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

# K8S
export KUBECONFIG=~/.kube/config
alias k="kubectl"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kl="kubectl logs -f"
alias kgpo="kubectl get pod"
alias kgd="kubectl get deployments"
alias kc="kubectx"
alias kns="kubens"
alias ke="kubectl exec -it"
alias kcns='kubectl config set-context --current --namespace'

# HTTP
alias http="xh"

# Nmap
alias nm="nmap -sC -sV -oN nmap"

# Rust
alias rfmt="cargo +nightly fmt --all"

# --- Vi Mode ---
bindkey jj vi-cmd-mode

# --- Navigation ---
cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

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

eval "$(zoxide init zsh)"

# --- Kubectl/AWS completion (lazy) ---
if command -v kubectl &>/dev/null; then
    source <(kubectl completion zsh)
fi
if [ -f /usr/local/bin/aws_completer ]; then
    complete -C '/usr/local/bin/aws_completer' aws
fi

# --- Nix ---
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# --- Go ---
export GOPATH="$HOME/go"
export GOCACHE="$HOME/Library/Caches/go-build"

# --- PATH ---
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.asdf/shims:$PATH"
export PATH="$HOME/.bb:$PATH"
export PATH="$HOME/.aztec/bin:$PATH"
export PATH="$HOME/.amp/bin:$PATH"
export NARGO_HOME="$HOME/.nargo"
export PATH="$NARGO_HOME/bin:$PATH"
export PATH="$HOME/.spicetify:$PATH"
alias starkup="curl --proto '=https' --tlsv1.2 -sSf https://sh.starkup.sh | sh -s --"
