# Brewfile
# Install everything: brew bundle
# Check what's missing: brew bundle check
# Remove unlisted packages: brew bundle cleanup --force

# ── Taps ─────────────────────────────────────────────────────────────────────
tap "hashicorp/tap"               # terraform (official tap, more up-to-date than core)
# tap "adoptopenjdk/openjdk"      # uncomment if doing Java dev

# ── Shell environment ─────────────────────────────────────────────────────────
brew "zsh"
brew "starship"
brew "zsh-syntax-highlighting"    # must be sourced after compinit
brew "zsh-autosuggestions"
brew "zsh-history-substring-search"
brew "direnv"                     # per-directory env vars
brew "zoxide"                     # smarter cd

# ── Terminal tools ────────────────────────────────────────────────────────────
brew "eza"                        # ls replacement
brew "bat"                        # cat replacement
brew "fd"                         # find replacement
brew "fzf"                        # fuzzy finder
brew "ripgrep"                    # grep replacement
brew "git-delta"                  # better git diffs
brew "glow"                       # markdown viewer in terminal
brew "watch"                      # periodic command re-run
brew "wget"
brew "jq"                         # JSON processor
brew "tree"                       # directory tree view
brew "ncdu"                       # disk usage explorer
brew "btop"                       # resource monitor
brew "tldr"                       # simplified man pages
brew "cheat"                      # community cheatsheets

# ── Git ───────────────────────────────────────────────────────────────────────
brew "git"
brew "gh"                         # GitHub CLI
brew "lazygit"                    # TUI git client
brew "tig"                        # TUI git log/diff browser
brew "gitleaks"                   # secret scanning

# ── Editors and multiplexers ──────────────────────────────────────────────────
brew "neovim"
brew "tmux"
brew "shfmt"                      # shell script formatter

# ── Language version managers ─────────────────────────────────────────────────
brew "pyenv"                      # Python version manager
brew "rbenv"                      # Ruby version manager
brew "jenv"                       # Java version manager (set JAVA_HOME per project)
# nvm — installed via install script, not brew (see Manual Steps in README)

# ── Python tooling ────────────────────────────────────────────────────────────
brew "uv"                         # fast Python package/project manager

# ── Go ────────────────────────────────────────────────────────────────────────
brew "go"
brew "gopls"                      # Go LSP

# ── Kubernetes ────────────────────────────────────────────────────────────────
brew "kubernetes-cli"             # kubectl
brew "k9s"                        # Kubernetes TUI
brew "helm"                       # Kubernetes package manager

# ── Infrastructure ────────────────────────────────────────────────────────────
brew "hashicorp/tap/terraform"
brew "terraform-ls"               # Terraform LSP

# ── Neovim LSP servers ────────────────────────────────────────────────────────
brew "lua-language-server"
brew "marksman"                   # Markdown LSP
brew "taplo"                      # TOML LSP
brew "helm-ls"                    # Helm LSP
brew "texlab"                     # LaTeX LSP
brew "kotlin-language-server"
brew "jdtls"                      # Java LSP

# ── Security / repo hygiene ───────────────────────────────────────────────────
brew "pre-commit"
brew "detect-secrets"

# ── AI / local models ─────────────────────────────────────────────────────────
brew "ollama"                     # local LLM (used by ai alias)

# ── Fonts ─────────────────────────────────────────────────────────────────────
cask "font-jetbrains-mono-nerd-font"   # required for icons in eza, nvim, starship
cask "font-inter"

# ── Terminal emulators ────────────────────────────────────────────────────────
cask "ghostty"

# ── Core apps ─────────────────────────────────────────────────────────────────
cask "docker-desktop"             # container runtime
cask "firefox"
cask "google-chrome"
cask "keeper-password-manager"
cask "postman"                    # API client
cask "typora"                     # markdown editor
cask "visual-studio-code"

# ── Personal apps (commented out — not suitable for all work environments) ────
# cask "anki"                     # flashcard study app
# cask "calibre"                  # e-book manager
# cask "discord"                  # chat / gaming
# cask "gimp"                     # image editor
# cask "obsidian"                 # knowledge base / notes
# cask "kiro-cli"                 # Amazon Kiro AI IDE (company policy may restrict AI tools)
# cask "signal"                   # encrypted messaging
# cask "spotify"                  # music streaming
# cask "superwhisper"             # voice transcription (cloud audio processing)
# cask "tailscale-app"            # VPN / mesh networking (use company-provided VPN instead)
# cask "utm"                      # virtual machines

# ── Tooling ───────────────────────────────────────────────────────────────────
# cask "android-platform-tools"   # uncomment if doing Android dev
