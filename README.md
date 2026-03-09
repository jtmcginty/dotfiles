# Dotfiles

Personal configuration files managed as git submodules.

## Structure

```
dotfiles/
├── nvim/        → github.com/jtmcginty/.nvim
├── tmux/        → github.com/jtmcginty/tmux-config
├── zsh-config/  → github.com/jtmcginty/zsh-config
├── zshenv       → symlinked to ~/.zshenv
├── zshrc        → symlinked to ~/.config/zsh/.zshrc
└── zprofile     → symlinked to ~/.config/zsh/.zprofile
```

## Zsh symlink structure

**Important:** the symlink targets are not all in the same place — this is intentional.

```
~/.zshenv               -> ~/dotfiles/zshenv          (in ~ because zsh reads it before ZDOTDIR is set)
~/.config/zsh/.zshrc    -> ~/dotfiles/zshrc            (in ZDOTDIR because zshenv sets ZDOTDIR=~/.config/zsh)
~/.config/zsh/.zprofile -> ~/dotfiles/zprofile         (same reason)
```

All source files live in `~/dotfiles/`. The symlink *targets* differ because `~/.zshenv`
must exist at `~` before `ZDOTDIR` is set, but once `zshenv` runs and sets
`ZDOTDIR=$HOME/.config/zsh`, zsh looks for all subsequent dotfiles there.

See `zsh-config/README.md` for full setup instructions and design rationale.

## Setup on New Machine

### With GitHub Account (SSH)

```bash
# Clone with submodules
git clone --recurse-submodules git@github.com:jtmcginty/dotfiles.git ~/dotfiles

# Or if already cloned
cd ~/dotfiles
git submodule update --init --recursive

# Symlink nvim and tmux configs
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# In tmux: prefix + I to install plugins

# Symlink zsh configs (note: different target dirs — see Zsh symlink structure above)
ln -sf ~/dotfiles/zshenv ~/.zshenv
mkdir -p ~/.config/zsh
ln -sf ~/dotfiles/zshrc ~/.config/zsh/.zshrc
ln -sf ~/dotfiles/zprofile ~/.config/zsh/.zprofile

# Symlink zsh-config module into ZDOTDIR
ln -sf ~/dotfiles/zsh-config ~/.config/zsh/zsh-config
```

### Without GitHub Account (HTTPS - Read Only)

```bash
# Clone with submodules using HTTPS
git clone --recurse-submodules https://github.com/jtmcginty/dotfiles.git ~/dotfiles

# Or if already cloned
cd ~/dotfiles
git submodule update --init --recursive

# Symlink nvim and tmux configs
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# In tmux: prefix + I to install plugins

# Symlink zsh configs (note: different target dirs — see Zsh symlink structure above)
ln -sf ~/dotfiles/zshenv ~/.zshenv
mkdir -p ~/.config/zsh
ln -sf ~/dotfiles/zshrc ~/.config/zsh/.zshrc
ln -sf ~/dotfiles/zprofile ~/.config/zsh/.zprofile

# Symlink zsh-config module into ZDOTDIR
ln -sf ~/dotfiles/zsh-config ~/.config/zsh/zsh-config
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
