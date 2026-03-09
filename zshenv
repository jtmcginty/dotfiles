# ~/.zshenv
# Sourced for EVERY zsh invocation - interactive, non-interactive, scripts, cron,
# tmux panes, terminal emulator tabs, everything.
# Keep fast. No slow inits. No output.

# Tell zsh where to find the rest of our config files
export ZDOTDIR="$HOME/.config/zsh"

# Source universal environment (includes Homebrew PATH)
[[ -f "$ZDOTDIR/env.zsh" ]] && source "$ZDOTDIR/env.zsh"
