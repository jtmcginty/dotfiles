# Dotfiles

Personal configuration files managed as git submodules.

## Structure

```
dotfiles/
├── nvim/     → github.com/jtmcginty/.nvim
└── tmux/     → github.com/jtmcginty/tmux-config
```

## Setup on New Machine

```bash
# Clone with submodules
git clone --recurse-submodules git@github.com:jtmcginty/dotfiles.git ~/dotfiles

# Or if already cloned
cd ~/dotfiles
git submodule update --init --recursive

# Symlink configs
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# In tmux: prefix + I to install plugins
```

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
