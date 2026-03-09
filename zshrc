# ~/.zshrc
# Sourced for interactive shells — anything you need at the prompt.
# Order matters here. Plugins and prompt must come before completions.

# ── Powerlevel10k instant prompt — must be FIRST, before any output ──────────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Homebrew guard for non-login interactive shells ───────────────────────────
# zprofile (which sets up Homebrew PATH) only runs for login shells.
# Terminal tabs, tmux panes, and other non-login interactive shells need this.
# path_helper is not a concern here — it only runs in /etc/zprofile (login only).
if [[ -z "$(command -v brew)" ]]; then
  [[ -f "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
  [[ -f "/usr/local/bin/brew" ]] && eval "$(/usr/local/bin/brew shellenv)"
fi

# ── Kiro CLI — must come first per its own requirement ───────────────────────
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && \
  builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# ── Load config files in order ────────────────────────────────────────────────
_zsh_config_dir="${ZDOTDIR:-$HOME/.config/zsh}"
for _zsh_file in \
  history \
  plugins \
  completion \
  aliases \
  functions \
  tools \
  secrets
do
  [[ -f "$_zsh_config_dir/${_zsh_file}.zsh" ]] && source "$_zsh_config_dir/${_zsh_file}.zsh"
done
unset _zsh_config_dir _zsh_file

# ── Kiro CLI — must come last per its own requirement ────────────────────────
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && \
  builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
