# ~/.zshenv
# Sourced for EVERY zsh invocation — interactive, non-interactive, scripts, cron.
# Keep this minimal and fast. No evals, no tool inits, no slow operations.

# Tell zsh where to find the rest of our config files
export ZDOTDIR="$HOME/.config/zsh"

# Source universal environment
[[ -f "$ZDOTDIR/env.zsh" ]] && source "$ZDOTDIR/env.zsh"
