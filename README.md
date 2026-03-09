# Dotfiles

Personal configuration files managed as git submodules.

## Structure

```
dotfiles/
├── eza/         → symlinked to ~/.config/eza
├── git/
│   └── ignore   → symlinked to ~/.config/git/ignore
├── k9s/         → symlinked to ~/.config/k9s
├── nvim/        → github.com/jtmcginty/.nvim
├── tmux/        → github.com/jtmcginty/tmux-config
├── zsh-config/  → github.com/jtmcginty/zsh-config
├── zshenv       → symlinked to ~/.zshenv
├── zshrc        → symlinked to ~/.config/zsh/.zshrc
└── zprofile     → symlinked to ~/.config/zsh/.zprofile
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

### With GitHub Account (SSH)

```bash
# Clone with submodules
git clone --recurse-submodules git@github.com:jtmcginty/dotfiles.git ~/dotfiles

# Or if already cloned
cd ~/dotfiles
git submodule update --init --recursive

# Symlink nvim, tmux, and tool configs
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/eza ~/.config/eza
ln -sf ~/dotfiles/k9s ~/.config/k9s
mkdir -p ~/.config/git
ln -sf ~/dotfiles/git/ignore ~/.config/git/ignore

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# In tmux: prefix + I to install plugins

# Symlink zshenv (must live at ~ before ZDOTDIR is set)
ln -sf ~/dotfiles/zshenv ~/.zshenv

# zsh-config submodule IS ZDOTDIR — symlink the whole directory
ln -sf ~/dotfiles/zsh-config ~/.config/zsh

# Link zshrc and zprofile into the submodule so zsh finds them via ZDOTDIR
ln -sf ~/dotfiles/zshrc ~/dotfiles/zsh-config/.zshrc
ln -sf ~/dotfiles/zprofile ~/dotfiles/zsh-config/.zprofile
```

### Without GitHub Account (HTTPS - Read Only)

```bash
# Clone with submodules using HTTPS
git clone --recurse-submodules https://github.com/jtmcginty/dotfiles.git ~/dotfiles

# Or if already cloned
cd ~/dotfiles
git submodule update --init --recursive

# Symlink nvim, tmux, and tool configs
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/eza ~/.config/eza
ln -sf ~/dotfiles/k9s ~/.config/k9s
mkdir -p ~/.config/git
ln -sf ~/dotfiles/git/ignore ~/.config/git/ignore

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# In tmux: prefix + I to install plugins

# Symlink zshenv (must live at ~ before ZDOTDIR is set)
ln -sf ~/dotfiles/zshenv ~/.zshenv

# zsh-config submodule IS ZDOTDIR — symlink the whole directory
ln -sf ~/dotfiles/zsh-config ~/.config/zsh

# Link zshrc and zprofile into the submodule so zsh finds them via ZDOTDIR
ln -sf ~/dotfiles/zshrc ~/dotfiles/zsh-config/.zshrc
ln -sf ~/dotfiles/zprofile ~/dotfiles/zsh-config/.zprofile
```

**Note:** HTTPS cloning is read-only. You won't be able to push changes, but you can use the configs.

## Updating

```bash
# Update all submodules to latest
cd ~/dotfiles
git submodule update --remote

# Commit the updates
git add .
git commit -m "Update submodules"
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
git commit -m "Add new-config submodule"
git push
```
