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
    emacs
    git
    nvm
    mongodb
    docker
    mas
    wget
)

echo "Installing packages..."
echo "this might take a while, please wait..."
for i in "${PACKAGES[@]}"
do
   if brew ls --versions $i > /dev/null; then
    brew update
    brew upgrade $i
    else
    brew install $i
    fi
done

echo "Installing Node 8"
nvm install 8

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew install cask

CASKS=(
    tunnelblick
    google-chrome
    google-hangouts
    iterm2
    slack
    sourcetree
    spectacle
    screennhero
    visual-studio-code
)

echo "Installing cask apps..."
echo "this might take a while, please wait..."
for i in "${CASKS[@]}"
do
   if brew cask ls --versions $i > /dev/null; then
    brew update
    brew cask upgrade $i
    else
    brew cask install $i
    fi
done

# echo brew cask install ${CASKS[@]}

echo "Starting mongodb"
brew services start mongodb

echo "Restarting mongodb"
brew services restart mongodb

echo "Installing global npm packages..."
npm install marked -g

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
[[ ! -d CTM ]] && mkdir CTM

echo "Bootstrapping complete"