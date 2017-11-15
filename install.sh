#!/usr/bin/env bash
CASKS_TO_INSTALL=()
PACKAGES_TO_INSTALL=()
BASIC_CASKS=(
    citrix-receiver
    tunnelblick
    google-chrome
    google-hangouts
    microsoft-lync
    skype
    slack
    spectacle
)
DEV_CASKS=(
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
DEV_PACKAGES=(
    git
    nvm
    mongodb
    docker
    mas
    wget
    node
)
INSTALL_PACKAGES=false
INSTALL_CASKS=false

# Parse command line arguments
while [[ $# > 0 ]]
do
    key="$1"
    case $key in
        -e|--env)
            nextArg="$2"
            while ! [[ "$nextArg" =~ -.* ]] && [[ $# > 1 ]]; do
                case $nextArg in
                    basic)
                        CASKS_TO_INSTALL=("${CASKS_TO_INSTALL[@]}" "${BASIC_CASKS[@]}")
                        INSTALL_CASKS=true
                    ;;
                    dev)
                        CASKS_TO_INSTALL=("${CASKS_TO_INSTALL[@]}" "${DEV_CASKS[@]}")
                        PACKAGES_TO_INSTALL=("${PACKAGES_TO_INSTALL[@]}" "${DEV_PACKAGES[@]}")
                        INSTALL_PACKAGES=true
                    ;;
                    *)
                        echo "$key $nextArg found!"
                    ;;
                esac
                if ! [[ "$2" =~ -.* ]]; then
                    shift
                    nextArg="$2"
                else
                    shift
                    break
                fi
            done
        ;;
        -h|--help)
            echo "App Installer:"
            echo
            echo "Usage:"
            echo "    install.sh [-e|--env] [(basic dev) ...]"
            echo
            echo "Installs the standard applications for a given environment or environments."
            echo
            echo "Examples:"
            echo
            echo "    install.sh -e basic"
            echo "    install.sh --env basic"
            echo "    install.sh -e basic dev"
            echo "    install.sh --env basic dev"
            echo "    install.sh -e basic --env dev"
            echo "    install.sh -e basic -e dev"

            exit 0
        ;;
        *)
            echo "Unknown flag $key"
        ;;
    esac
    shift
done

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
# Update homebrew recipes
echo "Updating Homebrew"
brew update

if ! brew info cask &>/dev/null; then
  brew install caskroom/cask/brew-cask
fi

# Remove duplicates from the arrays
CASKS_TO_INSTALL=$(echo "${CASKS_TO_INSTALL[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')
PACKAGES_TO_INSTALL=$(echo "${PACKAGES_TO_INSTALL[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')

if [ "$INSTALL_CASKS" = true ]; then
    echo "Installing cask apps..."
    echo "This might take a while please wait"
    for i in "${CASKS_TO_INSTALL[@]}"
    do
        if brew cask ls --versions $i > /dev/null; then
            brew cask upgrade $i
        else
            brew cask install $i
        fi
    done
fi

if [ "$INSTALL_PACKAGES" = true ] ; then
    echo "Installing packages..."
    echo "this might take a while, please wait..."
    for i in "${PACKAGES_TO_INSTALL[@]}"
    do
        echo "Installing $i"
        if brew ls --versions $i > /dev/null; then
            brew upgrade $i
        else
            brew install $i
        fi
    done
fi