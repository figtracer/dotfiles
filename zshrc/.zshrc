# --- Completion ---
autoload -Uz compinit && compinit

setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt AUTO_MENU
setopt AUTO_LIST

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'

# --- Shell Plugins ---
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept

# --- Starship ---
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# --- Environment ---
export LANG=en_US.UTF-8
export EDITOR=nvim

# --- Aliases ---
alias ls="ls -alh --color=auto"
alias la=tree
alias cat=bat
alias cl='clear'
alias v="nvim"

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

# Rust
alias rfmt="cargo +nightly fmt --all"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# --- Vi Mode ---
bindkey jj vi-cmd-mode

# --- Navigation ---
cx() { cd "$@" && ls; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && ls; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

eval "$(zoxide init zsh)"

# --- PATH ---
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
