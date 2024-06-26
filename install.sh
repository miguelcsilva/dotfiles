COMMAND_TITLE_COLOUR="\033[1;36m"
SEPARATOR_COLOUR="\033[1;30m"
NO_COLOR="\033[0m"
SEPARATOR="\n${DARK_GREY}---------------------------${NO_COLOR}\n"

print_title () {
    printf "$SEPARATOR${COMMAND_TITLE_COLOUR}$1${NO_COLOR}\n"
}

# Setup
# ref: https://askubuntu.com/a/970898
if ! [ $(id -u) = 0 ]; then
    echo "This script must be run with elevated privileges. Try: sudo ./install.sh" >&2
    exit 1
fi

if [ $SUDO_USER ]; then
    ORIGINAL_USER=$SUDO_USER
else
    ORIGINAL_USER=$(whoami)
fi

ORIGINAL_USER_HOME=$(sudo -u "$ORIGINAL_USER" sh -c 'echo $HOME')

## Advanced Package Tool (APT)
print_title "Updating apt"
apt update
## Git
print_title "Installing git"
apt install git -y
## Stow
print_title "Installing stow"
apt install stow

# Shell
## Zsh
print_title "Installing zsh"
apt install zsh -y
chsh -s $(which zsh)
chsh -s $(which zsh) $ORIGINAL_USER

# Essential tools
## Tree - folder structure
print_title "Installing tree"
apt install tree -y
## Bat - cat replacement
print_title "Installing bat"
apt install bat -y

# Python tools
## Pyenv
print_title "Installing pyenv"
rm -rf $ORIGINAL_USER_HOME/.pyenv/
apt install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y
curl https://pyenv.run | sudo -u $ORIGINAL_USER zsh

## Poetry
print_title "Installing poetry"
curl -sSL https://install.python-poetry.org | sudo -u $ORIGINAL_USER python3 -