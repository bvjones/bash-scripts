#!/usr/bin/env bash

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
# Update homebrew recipes
brew update

echo "Installing cask..."
brew install caskroom/cask/brew-cask

CASKS=(
    citrix-receiver 
    tunnelblick
    google-chrome
    google-hangouts
    microsoft-lync
    skype
    slack
    spectacle
)

echo "Installing cask apps..."
echo "This might take a while please wait"
for i in "${CASKS[@]}"
do
   if brew cask ls --versions $i > /dev/null; then
    brew update
    brew cask upgrade $i
    else
    brew cask install $i
    fi
done

echo "Bootstrapping complete"