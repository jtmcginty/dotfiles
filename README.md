# Dotfiles

Personal configuration files managed as git submodules.

## Structure

```
dotfiles/
├── Brewfile      → one-shot tool installation
├── eza/          → symlinked to ~/.config/eza
├── git/
│   └── ignore   → symlinked to ~/.config/git/ignore
├── k9s/          → symlinked to ~/.config/k9s
├── nvim/         → github.com/jtmcginty/nvim-config
├── starship.toml → symlinked to ~/.config/starship.toml
├── tmux/         → github.com/jtmcginty/tmux-config
├── zsh-config/   → github.com/jtmcginty/zsh-config
├── zshenv        → symlinked to ~/.zshenv
├── zshrc         → symlinked to ~/.config/zsh/.zshrc (via zsh-config)
└── zprofile      → symlinked to ~/.config/zsh/.zprofile (via zsh-config)
```

> **Note:** `~/.config/git/` is not fully symlinked because `config` (global git config) often
> contains machine-specific settings. Only `ignore` is tracked here.
>
> **Note:** k9s runtime data (cluster configs, screen dumps, logs) is stored in
> `~/Library/Application Support/k9s/` on macOS — not in `~/.config/k9s/` — so the
> symlink is safe to track.

## Zsh symlink structure

**Important:** `~/.config/zsh` is not a plain directory — it is a symlink to the
`zsh-config` submodule. That submodule IS `ZDOTDIR`.

```
~/.zshenv                  -> ~/dotfiles/zshenv        (must live at ~ — zsh reads it before ZDOTDIR is set)
~/.config/zsh              -> ~/dotfiles/zsh-config    (the submodule directory becomes ZDOTDIR)
~/.config/zsh/.zshrc       -> ~/dotfiles/zshrc         (symlink inside the submodule, resolved via ZDOTDIR)
~/.config/zsh/.zprofile    -> ~/dotfiles/zprofile      (same)
```

`zshenv` sets `ZDOTDIR=$HOME/.config/zsh`. From that point zsh looks for all startup
files inside the submodule. `zshrc` and `zprofile` live in the main dotfiles repo but
are linked into the submodule directory so zsh can find them via `ZDOTDIR`.

See `zsh-config/README.md` for full setup instructions and design rationale.

## Setup on New Machine

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Clone dotfiles

```bash
# SSH (recommended)
git clone --recurse-submodules git@github.com:jtmcginty/dotfiles.git ~/dotfiles

# HTTPS (read-only, no push)
git clone --recurse-submodules https://github.com/jtmcginty/dotfiles.git ~/dotfiles
```

### 3. Install tools via Brewfile

```bash
brew bundle --file=~/dotfiles/Brewfile
```

### 4. Manual steps (not in Homebrew)

**nvm** — install via the official script (brew install works but expects `~/.nvm`):
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

**Tmux plugin manager:**
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Then inside tmux: prefix + I to install plugins
```

**k9s screen dump directory:**
```bash
mkdir -p ~/.local/state/k9s/screen-dumps
```

### 5. Create symlinks

```bash
# Symlink nvim, tmux, and tool configs
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/eza ~/.config/eza
ln -sf ~/dotfiles/k9s ~/.config/k9s
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
mkdir -p ~/.config/git
ln -sf ~/dotfiles/git/ignore ~/.config/git/ignore

# Symlink zshenv (must live at ~ before ZDOTDIR is set)
ln -sf ~/dotfiles/zshenv ~/.zshenv

# zsh-config submodule IS ZDOTDIR — symlink the whole directory
ln -sf ~/dotfiles/zsh-config ~/.config/zsh

# Link zshrc and zprofile into the submodule so zsh finds them via ZDOTDIR
ln -sf ~/dotfiles/zshrc ~/dotfiles/zsh-config/.zshrc
ln -sf ~/dotfiles/zprofile ~/dotfiles/zsh-config/.zprofile
```

### 6. Install pre-commit hooks

```bash
for repo in ~/dotfiles ~/dotfiles/zsh-config ~/dotfiles/nvim ~/dotfiles/tmux; do
  (cd "$repo" && pre-commit install && pre-commit install --hook-type commit-msg)
done
```

## Updating

```bash
cd ~/dotfiles
git submodule update --remote
git add .
git commit -m "chore(deps): update submodules"
git push
```

## Adding New Config

```bash
# Create new config repo
cd ~/new-config
git init
# ... add files and commit ...
gh repo create new-config --private --source=. --remote=origin --push

# Add as submodule
cd ~/dotfiles
git submodule add git@github.com:jtmcginty/new-config.git new-config
git commit -m "feat: add new-config submodule"
git push
```
