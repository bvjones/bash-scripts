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
echo $PATH
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

echo "Cleaning up..."
brew cleanup

echo "Would you like to install Xcode (Y/N)?"
read XCODEMAYBE
# Convert to uppercase
XCODEMAYBE=$(echo $XCODEMAYBE | tr 'a-z' 'A-Z')
# If valid response..
if [ "${XCODEMAYBE}" = "Y" ]; then
    mas signout
    # Get Apple ID
    echo "What's your Apple ID?"
    read APPLEID
    # Install Xcode
    if mas signin --dialog "$APPLEID"; then
        echo "Installing Xcode..."
        mas install 497799835
    fi
fi

echo "Installing cask..."
brew install cask

CASKS=(
    firefox
    tunnelblick
    google-chrome
    iterm2
    slack
    sourcetree
    spectacle
    screenhero
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

source ~/.profile

echo "Starting mongodb"
brew services start mongodb

echo "Restarting mongodb"
brew services restart mongodb

echo "Installing global npm packages..."
npm install marked -g

echo "Bootstrapping complete"
