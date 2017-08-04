#!/usr/bin/env bash
#
echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

PACKAGES=(
    git
    nvm
    mongodb
    docker
    mas
    wget
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew install caskroom/cask/brew-cask

CASKS=(
    atom
    firefox
    tunnelblick
    google-chrome
    google-drive
    google-hangouts
    microsoft-lync
    gpgtools
    iterm2
    skype
    slack
    sourcetree
    spectacle
    screennhero
    visual-studio-code
)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo "Starting mongodb"
brew services start mongodb

echo "Restarting mongodb"
brew services restart mongodb

echo "Installing global npm packages..."
npm install marked -g

echo "Installing Node 8"
nvm install 8

echo "Configuring OSX..."
# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo "Creating folder structure..."
[[ ! -d Wiki ]] && mkdir Wiki
[[ ! -d Workspace ]] && mkdir Workspace

echo "Bootstrapping complete"