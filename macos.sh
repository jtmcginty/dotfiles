#!/usr/bin/env bash
# macos.sh
# Opinionated macOS system defaults.
# Run once on a new machine. Most settings require a logout/restart to take effect.
# Safe to re-run — all commands are idempotent.
#
# Usage: bash ~/dotfiles/macos.sh

set -euo pipefail

echo "Applying macOS defaults..."

# ── Close System Settings to prevent it overwriting changes ──────────────────
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

# ── Keyboard ──────────────────────────────────────────────────────────────────
# Fast key repeat (2 = ~30ms, default is 6)
defaults write NSGlobalDomain KeyRepeat -int 2
# Short delay before repeat starts (15 = ~225ms, default is 25)
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Disable auto-capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# Disable period substitution on double-space
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Remap Caps Lock → Escape (system-wide, all keyboards)
# Finds all keyboard product IDs and applies the remap to each
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}' > /dev/null
# Persist across reboots via launchd
HIDUTIL_PLIST="$HOME/Library/LaunchAgents/com.local.KeyRemapping.plist"
mkdir -p "$HOME/Library/LaunchAgents"
cat > "$HIDUTIL_PLIST" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.local.KeyRemapping</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/hidutil</string>
        <string>property</string>
        <string>--set</string>
        <string>{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF
launchctl load "$HIDUTIL_PLIST" 2>/dev/null || true

# ── Trackpad ──────────────────────────────────────────────────────────────────
# Natural scroll (default, explicit)
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true
# Enable tap to click (built-in and Bluetooth trackpad)
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# ── Dock ──────────────────────────────────────────────────────────────────────
# Position on left
defaults write com.apple.dock orientation -string "left"
# Auto-hide
defaults write com.apple.dock autohide -bool true
# Remove auto-hide delay
defaults write com.apple.dock autohide-delay -float 0
# Faster auto-hide animation
defaults write com.apple.dock autohide-time-modifier -float 0.3
# Icon size
defaults write com.apple.dock tilesize -int 48
# Don't show recent apps
defaults write com.apple.dock show-recents -bool false
# Minimize windows into their application icon
defaults write com.apple.dock minimize-to-application -bool true

# ── Finder ────────────────────────────────────────────────────────────────────
# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# Show path bar at bottom
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar at bottom
defaults write com.apple.finder ShowStatusBar -bool true
# Default new window opens to home directory
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"
# List view as default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Don't warn when changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Keep folders on top when sorting
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# Search current folder by default (not whole Mac)
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Avoid creating .DS_Store on network and USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# ── Screenshots ───────────────────────────────────────────────────────────────
mkdir -p "$HOME/Documents/screenshots"
defaults write com.apple.screencapture location -string "$HOME/Documents/screenshots"
# PNG format
defaults write com.apple.screencapture type -string "png"
# No window shadow
defaults write com.apple.screencapture disable-shadow -bool true

# ── Power / Sleep ─────────────────────────────────────────────────────────────
# Display sleep: 15 min on battery, 30 min on AC
sudo pmset -b displaysleep 15
sudo pmset -c displaysleep 30
# System sleep: 30 min on battery, never on AC
sudo pmset -b sleep 30
sudo pmset -c sleep 0

# ── Misc quality of life ──────────────────────────────────────────────────────
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
# Save to disk by default (not iCloud)
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Faster window resize animation
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# ── Apply changes ─────────────────────────────────────────────────────────────
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo ""
echo "Done. Some changes require a logout or restart to fully take effect."
