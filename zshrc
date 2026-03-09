# ~/.zshrc
# Sourced for interactive shells — anything you need at the prompt.
# Order matters here. Plugins and prompt must come before completions.

# Kiro CLI — must come first per its own requirement
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && \
  builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# Powerlevel10k instant prompt — must be near the top, before any output
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load config files in order
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

# Kiro CLI — must come last per its own requirement
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && \
  builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
