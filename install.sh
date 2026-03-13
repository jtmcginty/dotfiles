#!/usr/bin/env bash
# install.sh — create all dotfile symlinks
# Works regardless of where dotfiles are cloned or which user is running it.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Dotfiles directory: $DOTFILES_DIR"

mkdir -p "$HOME/.config/git"

# ── Configs ───────────────────────────────────────────────────────────────────
ln -sf "$DOTFILES_DIR/nvim"                "$HOME/.config/nvim"
ln -sf "$DOTFILES_DIR/tmux/tmux.conf"      "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/eza"                 "$HOME/.config/eza"
ln -sf "$DOTFILES_DIR/ghostty"             "$HOME/.config/ghostty"
ln -sf "$DOTFILES_DIR/k9s"                 "$HOME/.config/k9s"
ln -sf "$DOTFILES_DIR/starship.toml"       "$HOME/.config/starship.toml"
ln -sf "$DOTFILES_DIR/git/config"          "$HOME/.config/git/config"
ln -sf "$DOTFILES_DIR/git/commit-template" "$HOME/.config/git/commit-template"
ln -sf "$DOTFILES_DIR/git/ignore"          "$HOME/.config/git/ignore"

# ── Zsh ───────────────────────────────────────────────────────────────────────
# zshenv must live at ~ before ZDOTDIR is set
ln -sf "$DOTFILES_DIR/zshenv" "$HOME/.zshenv"

# zsh-config submodule IS ZDOTDIR — symlink the whole directory
ln -sf "$DOTFILES_DIR/zsh-config" "$HOME/.config/zsh"

# zshrc and zprofile are linked into the submodule with relative paths so the
# target is never hardcoded to a username or clone location.
ln -sf "../zshrc"    "$DOTFILES_DIR/zsh-config/.zshrc"
ln -sf "../zprofile" "$DOTFILES_DIR/zsh-config/.zprofile"

echo "Done. All symlinks created from $DOTFILES_DIR"
