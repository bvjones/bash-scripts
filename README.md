To run the shell scripts you will need to do the following -
- Add you SSH key to github
- `git clone git@github.com:bvjones/bash-scripts.git && cd bash-scripts`
- `sudo chown -R "$USER":admin /usr/local`
- `mkdir /Library/Caches/Homebrew`
- `sudo chown -R "$USER":admin /Library/Caches/Homebrew`
- `chmod +x ./basic-env.sh ./dev-env.sh`
- `./basic-env.sh` or `./dev-env.sh`

# Basic-env includes

## Installs
### Casks
- citrix-receiver 
- firefox
- tunnelblick
- google-chrome
- google-drive
- google-hangouts
- microsoft-lync
- skype
- slack
- spectacle

# Dev-env includes

## Installs
### Packages
- git
- nvm
- mongodb
- docker
- mas
- wget

### Casks
- tunnelblick
- google-chrome
- iterm2
- screenhero
- slack
- spectacle
- visual-studio-code
