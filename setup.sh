#!/usr/bin/env bash
set -e

echo "==> Installing Homebrew packages..."
brew install \
  neovim \
  tmux \
  starship \
  fzf \
  zoxide \
  bat \
  tree \
  stow \
  zsh-autosuggestions \
  ripgrep \
  fd

echo "==> Installing Rust toolchain..."
if ! command -v rustup &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

echo "==> Installing tmux plugin manager..."
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

echo "==> Stowing dotfiles..."
stow --target="$HOME/.config/nvim" nvim
stow --target="$HOME/.config/" starship
stow --target="$HOME/.config/tmux" tmux
stow --target="$HOME/.config/ghostty" ghostty
stow --target="$HOME/" zshrc

echo "==> Done! Open a new shell and run 'prefix + I' in tmux to install plugins."
