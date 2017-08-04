To run the shell scripts you will need to do the following -

- `git clone git@github.com:bvjones/bash-scripts.git && cd bash-scripts`
- `sudo chown -R "$USER":admin /usr/local`
- `mkdir /Library/Caches/Homebrew`
- `sudo chown -R "$USER":admin /Library/Caches/Homebrew`
- `chmod +x ./basic-env.sh ./dev-env.sh`
- `./basic-env.sh` or `./dev-env.sh`

## Basic-env includes

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