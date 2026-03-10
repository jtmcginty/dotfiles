# ~/.zshrc
# Sourced for interactive shells — anything you need at the prompt.
# Order matters here. Plugins and tools must come before completions.

# ── Homebrew guard for non-login interactive shells ───────────────────────────
# zprofile (which sets up Homebrew PATH) only runs for login shells.
# Terminal tabs, tmux panes, and other non-login interactive shells need this.
# path_helper is not a concern here — it only runs in /etc/zprofile (login only).
if [[ -z "$(command -v brew)" ]]; then
  [[ -f "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
  [[ -f "/usr/local/bin/brew" ]] && eval "$(/usr/local/bin/brew shellenv)"
fi

# ── Keybindings ───────────────────────────────────────────────────────────────
# Emacs line-editing mode (Ctrl-A/E, Ctrl-R, Ctrl-W, etc.)
bindkey -e
# fn+Delete → forward-delete (same key, opposite direction of backspace)
bindkey '\e[3~' delete-char

# ── Auto-start tmux ───────────────────────────────────────────────────────────
# Attach to the most recently used session, or create a new one.
# Skipped inside tmux, in VS Code, and in CI environments.
if command -v tmux &>/dev/null && [[ -z "$TMUX" && "$TERM_PROGRAM" != "vscode" && -z "$CI" ]]; then
  _tmux_session="$(tmux list-sessions -F '#{session_last_attached} #{session_name}' 2>/dev/null \
    | sort -r | head -n1 | cut -d' ' -f2)"
  if [[ -n "$_tmux_session" ]]; then
    exec tmux attach -t "$_tmux_session"
  else
    exec tmux new -s main
  fi
fi

# ── Kiro CLI — must come first per its own requirement ───────────────────────
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && \
  builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# ── Load config files in order ────────────────────────────────────────────────
_zsh_config_dir="${ZDOTDIR:-$HOME/.config/zsh}"
for _zsh_file in \
  history \
  plugins \
  tools \
  completion \
  aliases \
  functions \
  hooks \
  secrets
do
  [[ -f "$_zsh_config_dir/${_zsh_file}.zsh" ]] && source "$_zsh_config_dir/${_zsh_file}.zsh"
done
unset _zsh_config_dir _zsh_file

# ── Kiro CLI — must come last per its own requirement ────────────────────────
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && \
  builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
